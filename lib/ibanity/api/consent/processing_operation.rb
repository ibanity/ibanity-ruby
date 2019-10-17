module Ibanity
  module Consent
    class ProcessingOperation < Ibanity::BaseResource
      def self.create(consent_id:, **attributes)
        path = Ibanity.consent_api_schema["consent"]["processingOperations"]
          .gsub("{consentId}", consent_id)
          .gsub("{processingOperationId}", "")
        uri = Ibanity.client.build_uri(path)
        create_by_uri(uri: uri, resource_type: "processingOperation", attributes: attributes)
      end

      def self.list(consent_id:, **query_params)
        path = Ibanity.consent_api_schema["consent"]["processingOperations"]
        .gsub("{consentId}", consent_id)
        .gsub("{processingOperationId}", "")
        uri = Ibanity.client.build_uri(path)
        list_by_uri(uri: uri, query_params: query_params)
      end

      def self.find(id:, consent_id:)
        path = Ibanity.sandbox_api_schema["consent"]["processingOperations"]
          .gsub("{consentId}", consent_id)
          .gsub("{processingOperationId}", id)
        uri = Ibanity.client.build_uri(path)
        find_by_uri(uri: uri)
      end

      def self.revoke(id:, consent_id:)
        path = Ibanity.consent_api_schema["consent"]["processingOperation"]["revocations"]
          .gsub("{consentId}", consent_id)
          .gsub("{processingOperationId}", id)
        uri = Ibanity.client.build_uri(path)
        create_by_uri(uri: uri, resource_type: "processingOperation", attributes: [])
      end
    end
  end
end
