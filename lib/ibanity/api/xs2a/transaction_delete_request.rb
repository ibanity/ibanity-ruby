module Ibanity
  module Xs2a
    class TransactionDeleteRequest < Ibanity::BaseResource
      def self.create_for_application(idempotency_key: nil, **attributes)
        path = Ibanity.xs2a_api_schema["transactionDeleteRequests"]
        uri = Ibanity.client.build_uri(path)
        create_by_uri(uri: uri, resource_type: "transactionDeleteRequest", attributes: attributes, idempotency_key: idempotency_key)
      end

      def self.create_for_customer(idempotency_key: nil, customer_access_token:, **attributes)
        path = Ibanity.xs2a_api_schema["customer"]["transactionDeleteRequests"]
        uri = Ibanity.client.build_uri(path)
        create_by_uri(uri: uri, resource_type: "transactionDeleteRequest", attributes: attributes, idempotency_key: idempotency_key)
      end

      def self.create_for_financial_institution_and_account(idempotency_key: nil, financial_institution_id:, account_id:, customer_access_token:, **attributes)
        path = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["account"]["transactionDeleteRequests"]
                    .sub("{financialInstitutionId}", financial_institution_id)
                    .sub("{accountId}", account_id)
        uri = Ibanity.client.build_uri(path)
        create_by_uri(uri: uri, resource_type: "transactionDeleteRequest", attributes: attributes, idempotency_key: idempotency_key)
      end
    end
  end
end
