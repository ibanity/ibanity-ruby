module Ibanity
  module IsabelConnect
    class Token < Ibanity::OAuthResource
      def self.create(refresh_token: nil, authorization_code: nil, redirect_uri: nil, idempotency_key: nil)
        uri = Ibanity.isabel_connect_api_schema["oAuth2"]["token"]
        arguments =
          if refresh_token
            [
              ["grant_type", "refresh_token"],
              ["refresh_token", refresh_token]
            ]
          elsif authorization_code
            [
              ["grant_type", "authorization_code"],
              ["code", authorization_code],
              ["redirect_uri", redirect_uri]
            ]
          end
        create_by_uri(
          uri: uri,
          payload: URI.encode_www_form(arguments),
          idempotency_key: idempotency_key,
          headers: self.headers
        )
      end

      def self.delete(refresh_token:)
        uri = Ibanity.isabel_connect_api_schema["oAuth2"]["revoke"]
        arguments = [
          ["token", refresh_token]
        ]
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload, headers: self.headers)
      end

      private

      def self.headers
        {
          "Authorization": "Basic " + Base64.strict_encode64("#{Ibanity.client.isabel_connect_client_id}:#{Ibanity.client.isabel_connect_client_secret}"),
          "Content-Type": "application/x-www-form-urlencoded"
        }
      end
    end
  end
end
