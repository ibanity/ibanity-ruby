module Ibanity
  module PontoConnect
    module Sandbox
      class FinancialInstitutionAccount < Ibanity::BaseResource
        def self.list(access_token:, financial_institution_id:, **query_params)
          uri = Ibanity.ponto_connect_api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccounts"]
            .gsub("{financialInstitutionId}", financial_institution_id)
            .gsub("{financialInstitutionAccountId}", "")
          list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token)
        end

        def self.find(access_token:, id:, financial_institution_id:)
          uri = Ibanity.ponto_connect_api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccounts"]
            .gsub("{financialInstitutionId}", financial_institution_id)
            .gsub("{financialInstitutionAccountId}", id)
          find_by_uri(uri: uri, customer_access_token: access_token)
        end
      end
    end
  end
end
