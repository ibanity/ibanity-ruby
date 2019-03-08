module Ibanity
  module Xs2a
    class Customer < ::Ibanity::BaseResource
      def self.delete(customer_access_token:)
        uri = Ibanity.xs2a_api_schema["customer"]["self"]
        destroy_by_uri(uri: uri, customer_access_token: customer_access_token)
      end
    end
  end
end
