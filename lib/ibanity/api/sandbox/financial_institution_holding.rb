module Ibanity
  module Sandbox
    # <b>DEPRECATED:</b> Please use <tt>Ibanity::Xs2a::Sandbox::FinancialInstitutionHolding</tt> instead.
    class FinancialInstitutionHolding < Ibanity::BaseResource
      def self.create(financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:, idempotency_key: nil, **attributes)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionHolding.create` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionHolding.create instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionHolding.create(financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, financial_institution_account_id: financial_institution_account_id, idempotency_key: idempotency_key, attributes)
      end

      def self.list(financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:, **query_params)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionHolding.list` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionHolding.list instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionHolding.list(financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, financial_institution_account_id: financial_institution_account_id, query_params)
      end

      def self.find(id:, financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionHolding.find` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionHolding.find instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionHolding.find(id: id, financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, financial_institution_account_id: financial_institution_account_id)
      end

      def self.delete(id:, financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionHolding.delete` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionHolding.delete instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionHolding.find(id: id, financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, financial_institution_account_id: financial_institution_account_id)
      end
    end
  end
end
