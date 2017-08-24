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
  end
end
