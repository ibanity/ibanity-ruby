module Ibanity
  class Account < Ibanity::BaseResource
    def self.all_for_customer_in_financial_institution(financial_institution_id:, customer_access_token:)
      uri = Ibanity.api_schema["customer"]["financialInstitution"]["accounts"].sub(
        "{financialInstitutionId}", financial_institution_id
      ).sub("{accountId}", "")
      all_by_uri(uri, customer_access_token)
    end

    def self.get(id:, financial_institution_id:, customer_access_token:)
      uri = Ibanity.api_schema["customer"]["financialInstitution"]["accounts"]
        .sub("{financialInstitutionId}", financial_institution_id)
        .sub("{accountId}", id)
      find_by_uri(uri, customer_access_token)
    end
  end
end
