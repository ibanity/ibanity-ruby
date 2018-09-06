module Ibanity
  class Client

    attr_reader :base_uri, :signature_certificate, :signature_key

    def initialize(certificate:, key:, key_passphrase:, signature_certificate: nil, signature_certificate_id: nil, signature_key: nil, signature_key_passphrase: nil, api_scheme: "https", api_host: "api.ibanity.com", api_port: "443", ssl_ca_file: nil)
      @certificate           = OpenSSL::X509::Certificate.new(certificate)
      @key                   = OpenSSL::PKey::RSA.new(key, key_passphrase)
      if signature_certificate
        @signature_certificate    = OpenSSL::X509::Certificate.new(signature_certificate)
        @signature_certificate_id = signature_certificate_id
        @signature_key            = OpenSSL::PKey::RSA.new(signature_key, signature_key_passphrase)
      end
      @base_uri              = "#{api_scheme}://#{api_host}:#{api_port}"
      @ssl_ca_file           = ssl_ca_file
    end

    def get(uri:, query_params: {}, customer_access_token: nil, headers: nil)
      headers = build_headers(customer_access_token: customer_access_token, extra_headers: headers)
      execute(method: :get, uri: uri, headers: headers, query_params: query_params)
    end

    def post(uri:, payload:, query_params: {}, customer_access_token: nil, idempotency_key: nil)
      headers = build_headers(customer_access_token: customer_access_token, idempotency_key: idempotency_key)
      execute(method: :post, uri: uri, headers: headers, query_params: query_params, payload: payload)
    end

    def patch(uri:, payload:, query_params: {}, customer_access_token: nil, idempotency_key: nil)
      headers = build_headers(customer_access_token: customer_access_token, idempotency_key: idempotency_key)
      execute(method: :patch, uri: uri, headers: headers, query_params: query_params, payload: payload)
    end

    def delete(uri:, query_params: {}, customer_access_token: nil)
      headers = build_headers(customer_access_token: customer_access_token)
      execute(method: :delete, uri: uri, headers: headers, query_params: query_params)
    end

    def build_uri(path)
      URI.join(@base_uri, path).to_s
    end

    private

    def execute(method:, uri:, headers:, query_params: {}, payload: nil)
      if @signature_certificate
        signature = Ibanity::HttpSignature.new(
          certificate: @signature_certificate,
          certificate_id: @signature_certificate_id,
          key: @signature_key,
          method: method,
          uri: uri,
          query_params: query_params,
          headers: headers,
          payload: payload
        )
        headers.merge!(signature.signature_headers)
      end
      query = {
        method:          method,
        url:             uri,
        headers:         headers.merge(params: query_params),
        payload:         payload ? payload.to_json : nil,
        ssl_client_cert: @certificate,
        ssl_client_key:  @key,
        ssl_ca_file:     @ssl_ca_file
      }
      raw_response = RestClient::Request.execute(query) do |response, request, result, &block|
        if response.code >= 400
          body = JSON.parse(response.body)
          raise Ibanity::Error.new(body["errors"]), "Ibanity request failed."
        else
          response.return!(&block)
        end
      end
      JSON.parse(raw_response)
    end

    def build_headers(customer_access_token: nil, idempotency_key: nil, extra_headers: nil)
      headers = {
        content_type:  :json,
        accept:        :json,
      }
      headers["Authorization"]           = "Bearer #{customer_access_token}" unless customer_access_token.nil?
      headers["Ibanity-Idempotency-Key"] = idempotency_key unless idempotency_key.nil?
      if extra_headers.nil?
        headers
      else
        extra_headers.merge(headers)
      end
    end
  end
end
