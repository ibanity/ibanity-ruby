module Ibanity
  class SandboxAccount < Ibanity::BaseResource
    def self.create(sandbox_user_id:, financial_institution_id:, attributes:)
      path = Ibanity.api_schema["sandbox"]["accounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", "")
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri, "sandboxAccount", attributes)
    end

    def self.all(financial_institution_id:, sandbox_user_id:)
      path = Ibanity.api_schema["sandbox"]["accounts"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", "")
      uri = Ibanity.client.build_uri(path)
      all_by_uri(uri)
    end

    def self.all_for_user(sandbox_user_id)
      path = Ibanity.api_schema["sandbox"]["user"]["accounts"]
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", "")
      uri = Ibanity.client.build_uri(path)
      all_by_uri(uri)
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
