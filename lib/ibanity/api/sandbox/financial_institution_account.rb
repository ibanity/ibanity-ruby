module Ibanity
  module Sandbox
    # <b>DEPRECATED:</b> Please use <tt>Ibanity::Xs2a::Sandbox::FinancialInstitutionAccount</tt> instead.
    class FinancialInstitutionAccount < Ibanity::BaseResource
      def self.create(financial_institution_user_id:, financial_institution_id:, idempotency_key: nil, **attributes)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionAccount.create` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionAccount.create instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionAccount.create(financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id, idempotency_key: idempotency_key, attributes)
      end

      def self.list(financial_institution_id:, financial_institution_user_id:, **query_params)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionAccount.list` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionAccount.list instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionAccount.list(financial_institution_id: financial_institution_id, financial_institution_user_id: financial_institution_user_id, query_params)
      end

      def self.find(id:, financial_institution_user_id:, financial_institution_id:)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionAccount.find` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionAccount.find instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionAccount.find(id: id, financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id)
      end

      def self.delete(id:, financial_institution_user_id:, financial_institution_id:)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionAccount.delete` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionAccount.delete instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionAccount.delete(id: id, financial_institution_user_id: financial_institution_user_id, financial_institution_id: financial_institution_id)
      end
    end
  end
end
