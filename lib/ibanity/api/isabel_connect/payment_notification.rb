module Ibanity
  module IsabelConnect
    class PaymentNotification < Ibanity::BaseResource
      def self.list(access_token:, **query_params)
        list_by_uri(uri: notifications_uri, query_params: query_params, customer_access_token: access_token)
      end

      private_class_method def self.notifications_uri
        Ibanity.isabel_connect_api_schema["bulkPaymentInitiationRequests"]
               .sub("{bulkPaymentInitiationRequestId}", "notifications")
      end
    end
  end
end
