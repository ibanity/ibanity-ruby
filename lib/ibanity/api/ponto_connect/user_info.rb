module Ibanity
  module PontoConnect
    class UserInfo < Ibanity::OAuthResource
      def self.find(access_token:)
        uri = Ibanity.ponto_connect_api_schema["userinfo"]
        find_by_uri(uri: uri, customer_access_token: access_token)
      end
    end
  end
end
