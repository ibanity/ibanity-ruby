module Ibanity
  module IsabelConnect
    class BulkPaymentInitiationRequest < Ibanity::BaseResource
      def self.create(access_token:, raw_content:, filename:, idempotency_key: nil)
        uri = Ibanity.isabel_connect_api_schema["bulkPaymentInitiationRequests"].sub("{bulkPaymentInitiationRequestId}", "")
        create_file_by_uri(
          uri: uri,
          resource_type: "bulkPaymentInitiationRequest",
          raw_content: raw_content,
          customer_access_token: access_token,
          idempotency_key: idempotency_key,
          headers: {
            content_type: :xml,
            "Content-Disposition": "inline; filename=#{filename}"
          }
        )
      end

      def self.find(id:, access_token:)
        uri = Ibanity.isabel_connect_api_schema["bulkPaymentInitiationRequests"].sub("{bulkPaymentInitiationRequestId}", id)
        find_by_uri(uri: uri, customer_access_token: access_token)
      end
    end
  end
end
