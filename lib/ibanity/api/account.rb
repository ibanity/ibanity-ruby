module Ibanity
  class Account < Ibanity::BaseResource
    def self.all_for_financial_institution(financial_institution_id, access_token)
      uri = Ibanity.api_schema["financialInstitution"]["accounts"].sub(
        "{financialInstitutionId}", financial_institution_id
      ).sub("{accountId}", "")
      all_by_uri(uri, access_token)
    end
  end
end
