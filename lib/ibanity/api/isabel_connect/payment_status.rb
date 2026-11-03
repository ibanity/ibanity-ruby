module Ibanity
  module IsabelConnect
    class PaymentStatus < Ibanity::BaseResource
      def self.find(id:, access_token:, notification_id: nil)
        uri = Ibanity.isabel_connect_api_schema["bulkPaymentInitiationRequests"]
                     .sub("{bulkPaymentInitiationRequestId}", id) + "/payment-status"
        query_params = notification_id ? { notificationId: notification_id } : {}
        response = Ibanity.client.get(
          uri: uri,
          query_params: query_params,
          customer_access_token: access_token,
          expose_headers: [:x_notification_status]
        )

        notification_status = response[:headers][:x_notification_status]
        return { status: :up_to_date, notification_status: notification_status } if notification_status

        response[:body]
      end
    end
  end
end
