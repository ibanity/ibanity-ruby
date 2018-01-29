module Ibanity
  class SandboxAccount < Ibanity::BaseResource
    def self.create(sandbox_user_id:, financial_institution_id:, **attributes)
      path = Ibanity.api_schema["sandbox"]["accounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", "")
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri, "sandboxAccount", attributes)
    end

    def self.list(financial_institution_id:, sandbox_user_id:, **query_params)
      path = Ibanity.api_schema["sandbox"]["accounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", "")
      uri = Ibanity.client.build_uri(path)
      list_by_uri(uri, query_params)
    end

    def self.find(id:, sandbox_user_id:, financial_institution_id:)
      path = Ibanity.api_schema["sandbox"]["accounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", id)
      uri = Ibanity.client.build_uri(path)
      find_by_uri(uri)
    end

    def self.delete(id:, sandbox_user_id:, financial_institution_id:)
      path = Ibanity.api_schema["sandbox"]["accounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", id)
      uri = Ibanity.client.build_uri(path)
      destroy_by_uri(uri)
    end
  end
end
