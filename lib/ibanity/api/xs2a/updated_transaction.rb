module Ibanity
  module Xs2a
    class UpdatedTransaction < Ibanity::BaseResource
      def self.list(synchronization_id:, customer_access_token:, headers: nil,  **query_params)
        uri = Ibanity.xs2a_api_schema["customer"]["synchronization"]["updatedTransactions"]
          .sub("{synchronizationId}", synchronization_id)
          .sub("{updateTransactionId}", "")
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: customer_access_token, headers: headers)
      end
    end
  end
end
