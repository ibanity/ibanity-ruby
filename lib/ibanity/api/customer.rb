module Ibanity
  class Customer < ::Ibanity::BaseResource
    def self.delete(customer_access_token:)
      uri = Ibanity.api_schema[:xs2a]["customer"]["self"]
      destroy_by_uri(uri: uri, customer_access_token: customer_access_token)
    end
  end
end
