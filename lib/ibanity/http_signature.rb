require "base64"

module Ibanity
  class HttpSignature
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

    def payload_digest
      digest         = OpenSSL::Digest::SHA512.new
      string_payload = @payload.nil? ? "" : @payload.to_json
      digest.update(string_payload)
      base64 = Base64.urlsafe_encode64(digest.digest)
      "SHA-512=#{base64}"
    end

    def signature_algorithm
      @certificate.signature_algorithm.match("sha256") ? "rsa-sha256" : "rsa-sha512"
    end

    def headers_to_sign
      result = ["(request-target)", "host", "digest", "date"]
      result << "authorization" unless @headers["Authorization"].nil?
      @headers.keys.each do |header|
        result << header.to_s.downcase if header.to_s.match(/ibanity/i)
      end
      result
    end

    def request_target
      @uri.query = URI.encode_www_form(URI.decode_www_form(@uri.query.to_s).concat(@query_params.to_a)) if @query_params&.keys&.any?
      "#{@method} #{@uri.request_uri}"
    end

    def base64_signature
      digest = signature_algorithm == "rsa-sha256" ?  OpenSSL::Digest::SHA256.new :  OpenSSL::Digest::SHA512.new
      signature = @key.sign(digest, signing_string)
      Base64.urlsafe_encode64(signature)
    end

    def host
      @uri.host
    end

    def date
      @date ||= Time.now.utc.iso8601
    end

    def signing_string
      result = []
      headers_to_sign.each do |header_to_sign|
        value   = header_value(header_to_sign)
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
      when "date"
        date
      else
        camelized_header = header.split("-").collect(&:capitalize).join("-")
        @headers[camelized_header]
      end
    end

    def signature_headers
      {
        "Date"      => date,
        "Digest"    => payload_digest,
        "Signature" => "keyId=\"#{@certificate_id}\" algorithm=\"#{signature_algorithm}\" headers=\"#{headers_to_sign.join(" ")}\" signature=\"#{base64_signature}\""
      }
    end
  end
end
