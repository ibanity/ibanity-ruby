module Ibanity
  class SandboxFinancialInstitution < Ibanity::BaseResource
    def self.create(attributes)
      path     = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", "")
      uri      = Ibanity.client.build_uri(path)
      create_by_uri(uri, "financialInstitution", attributes)
    end

    def self.update(id:, **attributes)
      path = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", id)
      uri = Ibanity.client.build_uri(path)
      update_by_uri(uri, "financialInstitution", attributes)
    end

    def self.delete(id)
      uri = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", id)
      destroy_by_uri(uri)
    end
  end
end
