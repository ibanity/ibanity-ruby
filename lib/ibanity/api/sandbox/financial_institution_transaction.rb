module Ibanity
  module Sandbox
    # <b>DEPRECATED:</b> Please use <tt>Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction</tt> instead.
    class FinancialInstitutionTransaction < Ibanity::BaseResource
      def self.create(financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:, idempotency_key: nil, **attributes)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionTransaction.create` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.create instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.create(financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, financial_institution_account_id: financial_institution_account_id, idempotency_key: idempotency_key, attributes)
      end

      def self.list(financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:, **query_params)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionTransaction.list` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.list instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.list(financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, financial_institution_account_id: financial_institution_account_id, query_params)
      end

      def self.find(id:, financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionTransaction.find` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.find instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.find(id: id, financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, financial_institution_account_id: financial_institution_account_id)
      end

      def self.update(id:, financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:, idempotency_key: nil, **attributes)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionTransaction.create` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.create instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.create(id: id, financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, financial_institution_account_id: financial_institution_account_id, idempotency_key: idempotency_key, attributes)
      end

      def self.delete(id:, financial_institution_user_id:, financial_institution_id:, financial_institution_account_id:)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionTransaction.delete` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.delete instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionTransaction.find(id: id, financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, financial_institution_account_id: financial_institution_account_id)
      end
    end
  end
end
