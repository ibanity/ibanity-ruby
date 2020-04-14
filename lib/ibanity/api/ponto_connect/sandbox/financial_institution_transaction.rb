module Ibanity
  module PontoConnect
    module Sandbox
      class FinancialInstitutionTransaction < Ibanity::BaseResource
        def self.list(access_token:, financial_institution_account_id:, financial_institution_id:, **query_params)
          uri = Ibanity.ponto_connect_api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionTransactions"]
            .gsub("{financialInstitutionId}", financial_institution_id)
            .gsub("{financialInstitutionAccountId}", financial_institution_account_id)
            .gsub("{financialInstitutionTransactionId}", "")
          list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token)
        end

        def self.find(access_token:, id:, financial_institution_id:, financial_institution_account_id:)
          uri = Ibanity.ponto_connect_api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionTransactions"]
            .gsub("{financialInstitutionId}", financial_institution_id)
            .gsub("{financialInstitutionAccountId}", financial_institution_account_id)
            .gsub("{financialInstitutionTransactionId}", id)
          find_by_uri(uri: uri, customer_access_token: access_token)
        end

        def self.create(access_token:, financial_institution_id:, financial_institution_account_id:, **attributes)
          uri = Ibanity.ponto_connect_api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionTransactions"]
            .sub("{financialInstitutionId}", financial_institution_id)
            .sub("{financialInstitutionAccountId}", financial_institution_account_id)
            .sub("{financialInstitutionTransactionId}", "")
          create_by_uri(uri: uri, resource_type: "financialInstitutionTransaction", attributes: attributes, customer_access_token: access_token)
        end
      end
    end
  end
end
