module Ibanity
  class AccountInformationAccessRequest < Ibanity::BaseResource
    def self.create_for_financial_institution(financial_institution_id:, attributes:, access_token:)
      path = Ibanity.api_schema["customer"]["financialInstitution"]["accountInformationAccessRequests"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{accountInformationAccessRequestId}", "")
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri, "accountInformationAccessRequest", attributes, access_token)
    end
  end
end
