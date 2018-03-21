module Ibanity
  class SandboxFinancialInstitution < Ibanity::BaseResource
    def self.create(idempotency_key: nil, **attributes)
      path     = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", "")
      uri      = Ibanity.client.build_uri(path)
      create_by_uri(uri: uri, resource_type: "financialInstitution", attributes: attributes, idempotency_key: idempotency_key)
    end

    def self.update(id:, idempotency_key: nil, **attributes)
      path = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", id)
      uri = Ibanity.client.build_uri(path)
      update_by_uri(uri: uri, resource_type: "financialInstitution", attributes: attributes, idempotency_key: idempotency_key)
    end

    def self.delete(id:)
      uri = Ibanity.api_schema["sandbox"]["financialInstitutions"].gsub("{financialInstitutionId}", id)
      destroy_by_uri(uri: uri)
    end
  end
end
