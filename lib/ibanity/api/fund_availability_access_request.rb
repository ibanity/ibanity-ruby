module Ibanity
  class FundAvailabilityAccessRequest < Ibanity::BaseResource
    def self.create_for_financial_institution(financial_institution_id:, attributes:, access_token:)
      path = Ibanity.api_schema["financialInstitution"]["fundAvailabilityAccessRequests"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{fundAvailabilityAccessRequestId}", "")
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri, "fundAvailabilityAccessRequest", attributes, access_token)
    end
  end
end