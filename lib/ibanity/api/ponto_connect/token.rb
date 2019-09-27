module Ibanity
  module PontoConnect
    class Token < Ibanity::OAuthResource
      def self.create(refresh_token: nil, authorization_code: nil, redirect_uri: nil, idempotency_key: nil, code_verifier: nil)
        uri = Ibanity.ponto_connect_api_schema["oauth2"]["token"]
        grant_type = refresh_token ? "refresh_token" : "authorization_code"
        arguments = [
          ["grant_type", grant_type],
          ["client_id", Ibanity.client.ponto_connect_client_id]
        ]
        arguments << ["code", authorization_code] << ["code_verifier", code_verifier] << ["redirect_uri", redirect_uri] if authorization_code
        arguments << ["refresh_token", refresh_token] if refresh_token
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload, idempotency_key: idempotency_key, headers: self.headers)
      end

      def self.delete(refresh_token:)
        uri = Ibanity.ponto_connect_api_schema["oauth2"]["revoke"]
        arguments = [
          ["token", refresh_token]
        ]
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload, headers: self.headers)
      end

      private

      def self.headers
        {
          "Authorization": "Basic " + Base64.strict_encode64("#{Ibanity.client.ponto_connect_client_id}:#{Ibanity.client.ponto_connect_client_secret}"),
          "Content-Type": "application/x-www-form-urlencoded"
        }
      end
    end
  end
end
