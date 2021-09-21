module Ibanity
  module IsabelConnect
    class Token < Ibanity::OAuthResource
      def self.create(refresh_token: nil, authorization_code: nil, redirect_uri: nil, idempotency_key: nil)
        uri = Ibanity.isabel_connect_api_schema["oauth2"]["token"]
        arguments =
          if refresh_token
            [
              ["grant_type", "refresh_token"],
              ["refresh_token", refresh_token],
              ["client_id", Ibanity.client.isabel_connect_client_id],
              ["client_secret", Ibanity.client.isabel_connect_client_secret]
            ]
          elsif authorization_code
            [
              ["grant_type", "authorization_code"],
              ["code", authorization_code],
              ["client_id", Ibanity.client.isabel_connect_client_id],
              ["client_secret", Ibanity.client.isabel_connect_client_secret],
              ["redirect_uri", redirect_uri]
            ]
          end
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload, idempotency_key: idempotency_key)
      end

      def self.delete(token:)
        uri = Ibanity.isabel_connect_api_schema["oauth2"]["revoke"]
        arguments = [
          ["token", token],
          ["client_id", Ibanity.client.isabel_connect_client_id],
          ["client_secret", Ibanity.client.isabel_connect_client_secret]
        ]
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload)
      end
    end
  end
end
