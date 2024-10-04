module Ibanity
  module PontoConnect
    class PaymentRequestActivationRequest < Ibanity::BaseResource
      def self.create(access_token:, **attributes)
        uri = Ibanity.ponto_connect_api_schema["paymentRequestActivationRequests"]
        create_by_uri(uri: uri, resource_type: "paymentRequestActivationRequest", attributes: attributes, customer_access_token: access_token)
      end
    end
  end
end
