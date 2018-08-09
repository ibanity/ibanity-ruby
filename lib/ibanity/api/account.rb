module Ibanity
  class Account < Ibanity::BaseResource
    def self.list(financial_institution_id: nil, customer_access_token:, **query_params)
      uri = if financial_institution_id
        Ibanity.api_schema["customer"]["financialInstitution"]["accounts"].sub("{financialInstitutionId}", financial_institution_id).sub("{accountId}", "")
      else
        Ibanity.api_schema["customer"]["accounts"].sub("{accountId}", "")
      end
      list_by_uri(uri: uri, query_params: query_params, customer_access_token: customer_access_token)
    end

    def self.find(id:, financial_institution_id:, customer_access_token:)
      uri = Ibanity.api_schema["customer"]["financialInstitution"]["accounts"]
        .sub("{financialInstitutionId}", financial_institution_id)
        .sub("{accountId}", id)
      find_by_uri(uri: uri, customer_access_token: customer_access_token)
    end

    def self.delete(id:, financial_institution_id:, customer_access_token:)
      uri = Ibanity.api_schema["customer"]["financialInstitution"]["accounts"]
        .sub("{financialInstitutionId}", financial_institution_id)
        .sub("{accountId}", id)
      destroy_by_uri(uri: uri, customer_access_token: customer_access_token)
    end
  end
end
