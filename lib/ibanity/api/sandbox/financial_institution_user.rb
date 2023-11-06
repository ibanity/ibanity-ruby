module Ibanity
  module Sandbox
    # <b>DEPRECATED:</b> Please use <tt>Ibanity::Xs2a::Sandbox::FinancialInstitutionUser</tt> instead.
    class FinancialInstitutionUser < Ibanity::BaseResource
      def self.create(idempotency_key: nil, **attributes)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionUser.create` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.create instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.create(idempotency_key: idempotency_key, attributes)
      end

      def self.list(**query_params)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionUser.list` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.list instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.list(query_params)
      end

      def self.find(id:)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionUser.find` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.find instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.find(id: id)
      end

      def self.update(id:, idempotency_key: nil, **attributes)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionUser.update` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.update instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.find(id: id, idempotency_key: idempotency_key, attributes)
      end

      def self.delete(id:)
        warn "[DEPRECATION] `Ibanity::Sandbox::FinancialInstitutionUser.delete` is deprecated. Please use Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.delete instead"
        Ibanity::Xs2a::Sandbox::FinancialInstitutionUser.delete(id: id)
      end
    end
  end
end
