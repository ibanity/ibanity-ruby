module Ibanity
  class FinancialInstitution < Ibanity::BaseResource
    def self.create_sandbox(attributes)
      path     = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", "")
      uri      = Ibanity.client.build_uri(path)
      create_by_uri(uri, "financialInstitution", attributes)
    end

    def self.all
      uri = Ibanity.api_schema["financialInstitutions"].sub("{financialInstitutionId}", "")
      all_by_uri(uri)
    end

    def self.all_for_customer(customer_access_token)
      uri = Ibanity.api_schema["customer"]["financialInstitutions"]
      all_by_uri(uri, customer_access_token)
    end

    def self.find(id)
      uri = Ibanity.api_schema["financialInstitutions"].sub("{financialInstitutionId}", id)
      find_by_uri(uri)
    end

    def self.delete(id)
      uri = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", id)
      destroy_by_uri(uri)
    end
  end
end
