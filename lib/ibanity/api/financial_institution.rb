module Ibanity
  class FinancialInstitution < Ibanity::BaseResource
    def self.list(customer_access_token: nil, **query_params)
      uri = if customer_access_token.nil?
        Ibanity.api_schema["financialInstitutions"].sub("{financialInstitutionId}", "")
      else
        Ibanity.api_schema["customer"]["financialInstitutions"].sub("{financialInstitutionId}", "")
      end
      list_by_uri(uri: uri, query_params: query_params, customer_access_token: customer_access_token)
    end

    def self.find(id:)
      uri = Ibanity.api_schema["financialInstitutions"].sub("{financialInstitutionId}", id)
      find_by_uri(uri: uri)
    end

    def self.create(idempotency_key: nil, **attributes)
      path = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", "")
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri: uri, resource_type: "financialInstitution", attributes: attributes, idempotency_key: idempotency_key)
    end

    def self.update(id:, idempotency_key: nil, **attributes)
      path = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", id)
      uri = Ibanity.client.build_uri(path)
      update_by_uri(uri: uri, resource_type: "financialInstitution", attributes: attributes, idempotency_key: idempotency_key)
    end

    def self.delete(id:)
      uri = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", id)
      destroy_by_uri(uri: uri)
    end
  end
end
