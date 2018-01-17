module Ibanity
  class CustomerAccessToken < ::Ibanity::BaseResource
    def self.create(attributes:)
      path = ::Ibanity.api_schema["customerAccessTokens"]
      uri = ::Ibanity.client.build_uri(path)
      create_by_uri(uri, "customerAccessToken", attributes)
    end
  end
end