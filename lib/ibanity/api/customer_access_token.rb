module Ibanity
  class CustomerAccessToken < ::Ibanity::BaseResource
    def self.create(application_customer_reference, idempotency_key: nil, **attributes)
      path = ::Ibanity.api_schema["customerAccessTokens"]
      uri = ::Ibanity.client.build_uri(path)
      attributes.merge!(application_customer_reference: application_customer_reference)

      create_by_uri(uri: uri, resource_type: "customerAccessToken", attributes: attributes, idempotency_key: idempotency_key)
    end
  end
end
