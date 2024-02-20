module Ibanity
  module PontoConnect
    class PaymentRequest < Ibanity::BaseResource
      def self.find(access_token:, account_id:, id:)
        uri = Ibanity.ponto_connect_api_schema["account"]["paymentRequests"].sub("{accountId}", account_id).sub("{paymentRequestId}", id)
        find_by_uri(uri: uri, customer_access_token: access_token)
      end

      def self.create(account_id:, access_token: nil, **attributes)
        uri = Ibanity.ponto_connect_api_schema["account"]["paymentRequests"].gsub("{accountId}", account_id).gsub("{paymentRequestId}", "")
        create_by_uri(uri: uri, resource_type: "payment", attributes: attributes, customer_access_token: access_token)
      end

      def self.delete(id:, account_id:, access_token:)
        uri = Ibanity.ponto_connect_api_schema["account"]["paymentRequests"].gsub("{accountId}", account_id).gsub("{paymentRequestId}", id)
        destroy_by_uri(uri: uri, customer_access_token: access_token)
      end
    end
  end
end
