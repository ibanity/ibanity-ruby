module Ibanity
  class PaymentInitiationRequest < Ibanity::BaseResource
    def self.create_for_financial_institution(financial_institution_id:, customer_access_token:, **attributes)
      path = Ibanity.api_schema["customer"]["financialInstitution"]["paymentInitiationRequests"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .sub("{paymentInitiationRequestId}", "")
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri, "accountInformationAccessRequest", attributes, customer_access_token)
    end

    def self.find(id:, financial_institution_id:, customer_access_token:)
      uri = Ibanity.api_schema["customer"]["financialInstitution"]["paymentInitiationRequests"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .sub("{paymentInitiationRequestId}", id)
      find_by_uri(uri, customer_access_token)
    end
  end
end
