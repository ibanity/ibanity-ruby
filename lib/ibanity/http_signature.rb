require "base64"

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

    private

    def payload_digest
      digest         = OpenSSL::Digest::SHA512.new
      string_payload = @payload.nil? ? "" : @payload
      digest.update(string_payload)
      base64 = Base64.urlsafe_encode64(digest.digest)
      "SHA-512=#{base64}"
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
