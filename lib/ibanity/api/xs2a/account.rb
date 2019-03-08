module Ibanity
  module Xs2a
    class Account < Ibanity::BaseResource
      def self.list(financial_institution_id: nil, customer_access_token:, headers: nil, **query_params)
        uri = if financial_institution_id
          Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["accounts"].sub("{financialInstitutionId}", financial_institution_id).sub("{accountId}", "")
        else
          Ibanity.xs2a_api_schema["customer"]["accounts"].sub("{accountId}", "")
        end
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: customer_access_token, headers: headers)
      end

      def self.find(id:, financial_institution_id:, customer_access_token:, headers: nil)
        uri = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["accounts"]
          .sub("{financialInstitutionId}", financial_institution_id)
          .sub("{accountId}", id)
        find_by_uri(uri: uri, customer_access_token: customer_access_token, headers: headers)
      end

      def self.delete(id:, financial_institution_id:, customer_access_token:)
        uri = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["accounts"]
          .sub("{financialInstitutionId}", financial_institution_id)
          .sub("{accountId}", id)
        destroy_by_uri(uri: uri, customer_access_token: customer_access_token)
      end
    end
  end
end
