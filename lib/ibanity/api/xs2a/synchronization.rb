module Ibanity
  module Xs2a
    class Synchronization < Ibanity::BaseResource
      def self.list(financial_institution_id:, account_information_access_request_id:, customer_access_token:, headers: nil,  **query_params)
        uri = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["accountInformationAccessRequest"]["initialAccountTransactionsSynchronizations"]
            .sub("{financialInstitutionId}", financial_institution_id)
             .sub("{accountInformationAccessRequestId}", account_information_access_request_id)
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: customer_access_token, headers: headers)
      end

      def self.create(customer_access_token:, **attributes)
        uri = Ibanity.xs2a_api_schema["customer"]["synchronizations"]
          .sub("{synchronizationId}", "")
        create_by_uri(uri: uri, resource_type: "synchronization", attributes: attributes, customer_access_token: customer_access_token)
      end

      def self.find(id:, customer_access_token:)
        uri = Ibanity.xs2a_api_schema["customer"]["synchronizations"]
          .sub("{synchronizationId}", id)
        find_by_uri(uri: uri, customer_access_token: customer_access_token)
      end
    end
  end
end
