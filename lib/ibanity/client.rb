module Ibanity
  class Client

    attr_reader :base_uri

    def initialize(certificate:, key:, key_passphrase:, api_scheme: "https", api_host: "api.ibanity.com", api_port: "443", ssl_ca_file: nil)
      @certificate = OpenSSL::X509::Certificate.new(certificate)
      @key         = OpenSSL::PKey::RSA.new(key, key_passphrase)
      @base_uri    = "#{api_scheme}://#{api_host}:#{api_port}"
      @ssl_ca_file = ssl_ca_file
    end

    def get(uri, query_params = {}, customer_access_token = nil)
      execute(:get, uri, build_headers(customer_access_token), query_params, nil)
    end

    def post(uri, payload, query_params = {}, customer_access_token = nil)
      execute(:post, uri, build_headers(customer_access_token), query_params, payload)
    end

    def patch(uri, payload, query_params = {}, customer_access_token = nil)
      execute(:patch, uri, build_headers(customer_access_token), query_params, payload)
    end

    def delete(uri, query_params = {}, customer_access_token = nil)
      execute(:delete, uri, build_headers(customer_access_token), query_params)
    end

    def build_uri(path)
      URI.join(@base_uri, path).to_s
    end

    private

    def execute(method, uri, headers, query_params = {}, payload = nil)
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

    def build_headers(customer_access_token = nil)
      {
        content_type:  :json,
        accept:        :json,
        authorization: customer_access_token.nil? ? nil : "Bearer #{customer_access_token}"
      }
    end
  end
end
