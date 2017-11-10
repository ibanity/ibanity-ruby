module Ibanity
  class AccessToken < Ibanity::BaseResource
    def self.create_for_financial_institution(financial_institution_id:, attributes:)
      path = Ibanity.api_schema["financialInstitution"]["accessTokens"]
        .gsub("{financialInstitutionId}", financial_institution_id)
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri, "accessToken", attributes)
    end
  end
end