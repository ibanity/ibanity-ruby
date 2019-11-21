module Ibanity
  module Xs2a
    class Holding < Ibanity::BaseResource
      def self.list(financial_institution_id:, account_id:, customer_access_token:, headers: nil,  **query_params)
        uri = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["holdings"]
          .sub("{financialInstitutionId}", financial_institution_id)
          .sub("{accountId}", account_id)
          .sub("{holdingId}", "")
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: customer_access_token, headers: headers)
      end

      def self.find(id:, financial_institution_id:, account_id:, customer_access_token:)
        uri = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["holdings"]
          .sub("{financialInstitutionId}", financial_institution_id)
          .sub("{accountId}", account_id)
          .sub("{holdingId}", id)
        find_by_uri(uri: uri, customer_access_token: customer_access_token)
      end
    end
  end
end
