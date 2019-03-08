module Ibanity
  module Xs2a
    class PaymentInitiationRequest < Ibanity::BaseResource
      def self.create_for_financial_institution(financial_institution_id:, customer_access_token:, idempotency_key: nil, **attributes)
        path = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["paymentInitiationRequests"]
          .gsub("{financialInstitutionId}", financial_institution_id)
          .sub("{paymentInitiationRequestId}", "")
        uri = Ibanity.client.build_uri(path)
        create_by_uri(
          uri: uri,
          resource_type: "accountInformationAccessRequest",
          attributes: attributes,
          customer_access_token: customer_access_token,
          idempotency_key: idempotency_key
        )
      end

      def self.find(id:, financial_institution_id:, customer_access_token:)
        uri = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["paymentInitiationRequests"]
          .gsub("{financialInstitutionId}", financial_institution_id)
          .sub("{paymentInitiationRequestId}", id)
        find_by_uri(uri: uri, customer_access_token: customer_access_token)
      end
    end
  end
end
