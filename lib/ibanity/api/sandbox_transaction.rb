module Ibanity
  class SandboxTransaction < Ibanity::BaseResource
    def self.create(sandbox_user_id:, financial_institution_id:, sandbox_account_id:, idempotency_key: nil, **attributes)
      path = Ibanity.api_schema["sandbox"]["transactions"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", sandbox_account_id)
        .gsub("{sandboxTransactionId}", "")
      uri = Ibanity.client.build_uri(path)
      create_by_uri(uri: uri, resource_type: "sandboxTransaction", attributes: attributes, idempotency_key: idempotency_key)
    end

    def self.list(sandbox_user_id:, financial_institution_id:, sandbox_account_id:, **query_params)
      path = Ibanity.api_schema["sandbox"]["transactions"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", sandbox_account_id)
        .gsub("{sandboxTransactionId}", "")
      uri = Ibanity.client.build_uri(path)
      list_by_uri(uri: uri, query_params: query_params)
    end

    def self.find(id:, sandbox_user_id:, financial_institution_id:, sandbox_account_id:)
      path = Ibanity.api_schema["sandbox"]["transactions"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", sandbox_account_id)
        .gsub("{sandboxTransactionId}", id)
      uri = Ibanity.client.build_uri(path)
      find_by_uri(uri: uri)
    end

    def self.delete(id:, sandbox_user_id:, financial_institution_id:, sandbox_account_id:)
      path = Ibanity.api_schema["sandbox"]["transactions"]
        .gsub("{financialInstitutionId}", financial_institution_id)
        .gsub("{sandboxUserId}", sandbox_user_id)
        .gsub("{sandboxAccountId}", sandbox_account_id)
        .gsub("{sandboxTransactionId}", id)
      uri = Ibanity.client.build_uri(path)
      destroy_by_uri(uri: uri)
    end
  end
end
