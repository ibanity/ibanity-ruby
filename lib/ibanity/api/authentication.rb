module Ibanity
  class Authentication < Ibanity::BaseResource
    def self.create_for_financial_institution(financial_institution_id:, attributes:)
      path = Ibanity.api_schema["financialInstitution"]["authentications"]
        .gsub("{financialInstitutionId}", financial_institution_id)
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri, "authentication", attributes)
    end
  end
end
