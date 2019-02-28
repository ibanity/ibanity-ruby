module Ibanity
  module IsabelConnect
    class RefreshToken < Ibanity::OAuthResource
      def self.create(authorization_code:, idempotency_key: nil)
        uri = Ibanity.isabel_connect_schema["refreshToken"]["create"]
        arguments = [
          ["grant_type", "authorization_code"],
          ["code", authorization_code],
          ["client_id", Ibanity.client.client_id],
          ["client_secret", Ibanity.client.client_secret],
          ["redirect_uri", "https://192.168.126.94:9980"]
        ]
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload, idempotency_key: idempotency_key)
      end

      def self.delete(token:)
        uri = Ibanity.isabel_connect_schema["refreshToken"]["revoke"]
        arguments = [
          ["token", token],
          ["client_id", Ibanity.client.client_id],
          ["client_secret", Ibanity.client.client_secret]
        ]
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload)
      end
    end
  end
end
