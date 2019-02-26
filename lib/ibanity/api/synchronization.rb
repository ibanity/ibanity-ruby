module Ibanity
  class Synchronization < Ibanity::BaseResource
    def self.create(customer_access_token:, **attributes)
      uri = Ibanity.api_schema[:xs2a]["customer"]["synchronizations"]
        .sub("{synchronizationId}", "")
      create_by_uri(uri: uri, resource_type: "synchronization", attributes: attributes, customer_access_token: customer_access_token)
    end

    def self.find(id:, customer_access_token:)
      uri = Ibanity.api_schema[:xs2a]["customer"]["synchronizations"]
        .sub("{synchronizationId}", id)
      find_by_uri(uri: uri, customer_access_token: customer_access_token)
    end
  end
end
