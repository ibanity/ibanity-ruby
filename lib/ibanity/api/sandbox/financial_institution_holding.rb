module Ibanity
  module Sandbox
    class FinancialInstitutionHolding < Ibanity::BaseResource
      def self.create(financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:, idempotency_key: nil, **attributes)
        path = Ibanity.sandbox_api_schema["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionHoldings"]
          .gsub("{financialInstitutionId}", financial_institution_id)
          .gsub("{financialInstitutionUserId}", financial_institution_user_id)
          .gsub("{financialInstitutionAccountId}", financial_institution_account_id)
          .gsub("{financialInstitutionHoldingId}", "")
        uri = Ibanity.client.build_uri(path)
        create_by_uri(uri: uri, resource_type: "financialInstitutionHolding", attributes: attributes, idempotency_key: idempotency_key)
      end

      def self.list(financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:, **query_params)
        path = Ibanity.sandbox_api_schema["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionHoldings"]
          .gsub("{financialInstitutionId}", financial_institution_id)
          .gsub("{financialInstitutionUserId}", financial_institution_user_id)
          .gsub("{financialInstitutionAccountId}", financial_institution_account_id)
          .gsub("{financialInstitutionHoldingId}", "")
        uri = Ibanity.client.build_uri(path)
        list_by_uri(uri: uri, query_params: query_params)
      end

      def self.find(id:, financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:)
        path = Ibanity.sandbox_api_schema["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionHoldings"]
          .gsub("{financialInstitutionId}", financial_institution_id)
          .gsub("{financialInstitutionUserId}", financial_institution_user_id)
          .gsub("{financialInstitutionAccountId}", financial_institution_account_id)
          .gsub("{financialInstitutionHoldingId}", id)
        uri = Ibanity.client.build_uri(path)
        find_by_uri(uri: uri)
      end

      def self.delete(id:, financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:)
        path = Ibanity.sandbox_api_schema["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionHoldings"]
          .gsub("{financialInstitutionId}", financial_institution_id)
          .gsub("{financialInstitutionUserId}", financial_institution_user_id)
          .gsub("{financialInstitutionAccountId}", financial_institution_account_id)
          .gsub("{financialInstitutionHoldingId}", id)
        uri = Ibanity.client.build_uri(path)
        destroy_by_uri(uri: uri)
      end
    end
  end
end
