module Ibanity
  module Xs2a
    module Sandbox
      class FinancialInstitutionUser < Ibanity::BaseResource
        def self.create(idempotency_key: nil, **attributes)
          path     = Ibanity.sandbox_api_schema["financialInstitutionUsers"].gsub("{financialInstitutionUserId}", "")
          uri      = Ibanity.client.build_uri(path)
          create_by_uri(uri: uri, resource_type: "financialInstitutionUser", attributes: attributes, idempotency_key: idempotency_key)
        end

        def self.list(**query_params)
          uri = Ibanity.sandbox_api_schema["financialInstitutionUsers"].sub("{financialInstitutionUserId}", "")
          list_by_uri(uri: uri, query_params: query_params)
        end

        def self.find(id:)
          uri = Ibanity.sandbox_api_schema["financialInstitutionUsers"].sub("{financialInstitutionUserId}", id)
          find_by_uri(uri: uri)
        end

        def self.update(id:, idempotency_key: nil, **attributes)
          path = Ibanity.sandbox_api_schema["financialInstitutionUsers"].sub("{financialInstitutionUserId}", id)
          uri = Ibanity.client.build_uri(path)
          update_by_uri(uri: uri, resource_type: "financialInstitutionUser", attributes: attributes, idempotency_key: idempotency_key)
        end

        def self.delete(id:)
          uri = Ibanity.sandbox_api_schema["financialInstitutionUsers"].sub("{financialInstitutionUserId}", id)
          destroy_by_uri(uri: uri)
        end
      end
    end
  end
end
