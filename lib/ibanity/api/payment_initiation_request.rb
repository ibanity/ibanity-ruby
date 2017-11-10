module Ibanity
  class PaymentInitiationRequest < Ibanity::BaseResource
    def self.create_for_financial_institution(financial_institution_id:, attributes:, access_token:)
      path = Ibanity.api_schema["financialInstitution"]["paymentInitiationRequests"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{paymentInitiationRequestId}", "")
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri, "paymentInitiationRequest", attributes, access_token)
    end
  end
end