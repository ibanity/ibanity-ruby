require "base64"
require "pathname"

module Ibanity
  class HttpSignature
    PSS_DIGEST_ALGORITHM = "SHA256"
    SIGNATURE_ALGORITHM  = "hs2019"

    def initialize(certificate:, certificate_id:, key:, method:, uri:, query_params:, headers:, payload:)
      @certificate    = certificate
      @certificate_id = certificate_id
      @key            = key
      @method         = method
      @uri            = URI(uri)
      @headers        = headers
      @payload        = payload
      @query_params   = query_params
    end

    def signature_headers
      {
        "Digest"    => payload_digest,
        "Signature" => [
          %(keyId="#{@certificate_id}"),
          %(created="#{date}"),
          %(algorithm="#{SIGNATURE_ALGORITHM}"),
          %(headers="#{headers_to_sign.join(" ")}"),
          %(signature="#{base64_signature}"),
        ].join(",")
      }
    end

    def payload_digest
      @payload_digest ||= compute_digest
    end

    def compute_digest
      case @payload
        when NilClass
          digest = compute_digest_string("")
        when String
          digest = compute_digest_string(@payload)
        when Pathname
          digest = compute_digest_file(@payload)
      end
      base64 = Base64.urlsafe_encode64(digest.digest)
      "SHA-512=#{base64}"
    end

    def compute_digest_string(str)
      digest = OpenSSL::Digest::SHA512.new
      digest.update(str)
    end

    def compute_digest_file(pathname)
      digest = OpenSSL::Digest::SHA512.new
      File.open(pathname, 'rb') do |f|
        while buffer = f.read(256_000)
          digest << buffer
        end
      end
      digest
    end

    def headers_to_sign
      result = ["(request-target)", "host", "digest", "(created)"]
      result << "authorization" unless @headers["Authorization"].nil?
      @headers.keys.each do |header|
        result << header.to_s.downcase if header.to_s.match(/ibanity/i)
      end
      result
    end

    def request_target
      @uri.query = RestClient::Utils.encode_query_string(@query_params) if @query_params&.keys&.any?
      "#{@method} #{@uri.request_uri}"
    end

    def base64_signature
      signature = @key.sign_pss(PSS_DIGEST_ALGORITHM, signing_string, salt_length: :digest, mgf1_hash: PSS_DIGEST_ALGORITHM)
      Base64.urlsafe_encode64(signature)
    end

    def host
      @uri.host
    end

    def date
      @date ||= Time.now.to_i
    end

    def signing_string
      result = []
      headers_to_sign.each do |header_to_sign|
        value = header_value(header_to_sign)
        result << "#{header_to_sign}: #{value}"
      end
      result.join("\n")
    end

    def header_value(header)
      case header
      when "(request-target)"
        request_target
      when "host"
        host
      when "digest"
        payload_digest
      when "(created)"
        date
      else
        camelized_header = header.split("-").collect(&:capitalize).join("-")
        @headers[camelized_header]
      end
    end
  end
end
