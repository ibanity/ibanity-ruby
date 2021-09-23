module Ibanity
  module IsabelConnect
    class AccessToken < Ibanity::OAuthResource
      def self.create(refresh_token:, idempotency_key: nil)
        warn "WARNING: Ibanity::IsabelConnect::AccessToken.create is deprecated, please use Ibanity::IsabelConnect::Token.create instead"
        uri = Ibanity.isabel_connect_api_schema["oAuth2"]["accessTokens"]
        arguments = [
          ["grant_type", "refresh_token"],
          ["refresh_token", refresh_token],
          ["client_id", Ibanity.client.isabel_connect_client_id],
          ["client_secret", Ibanity.client.isabel_connect_client_secret]
        ]
        payload = URI.encode_www_form(arguments)
        create_by_uri(uri: uri, payload: payload, idempotency_key: idempotency_key)
      end
    end
  end
end
