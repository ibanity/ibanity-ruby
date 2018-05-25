module Ibanity
  class FinancialInstitutionAccount < Ibanity::BaseResource
    def self.create(financial_institution_user_id:, financial_institution_id:, idempotency_key: nil, **attributes)
      path = Ibanity.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{financialInstitutionUserId}", financial_institution_user_id)
        .gsub("{financialInstitutionAccountId}", "")
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri: uri, resource_type: "financialInstitutionAccount", attributes: attributes, idempotency_key: idempotency_key)
    end

    def self.list(financial_institution_id:, financial_institution_user_id:, **query_params)
      path = Ibanity.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{financialInstitutionUserId}", financial_institution_user_id)
        .gsub("{financialInstitutionAccountId}", "")
      uri = Ibanity.client.build_uri(path)
      list_by_uri(uri: uri, query_params: query_params)
    end

    def self.find(id:, financial_institution_user_id:, financial_institution_id:)
      path = Ibanity.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{financialInstitutionUserId}", financial_institution_user_id)
        .gsub("{financialInstitutionAccountId}", id)
      uri = Ibanity.client.build_uri(path)
      find_by_uri(uri: uri)
    end

    def self.delete(id:, financial_institution_user_id:, financial_institution_id:)
      path = Ibanity.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{financialInstitutionUserId}", financial_institution_user_id)
        .gsub("{financialInstitutionAccountId}", id)
      uri = Ibanity.client.build_uri(path)
      destroy_by_uri(uri: uri)
    end
  end
end
