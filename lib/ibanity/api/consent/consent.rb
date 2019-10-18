module Ibanity
  module Consent
    class Consent < Ibanity::BaseResource
      def self.create(idempotency_key: nil, **attributes)
        path = Ibanity.consent_api_schema["consents"].gsub("{consentId}", "")
        uri = Ibanity.client.build_uri(path)
        create_by_uri(uri: uri, resource_type: "consent", attributes: attributes, idempotency_key: idempotency_key)
      end

      def self.list(**query_params)
        path = Ibanity.consent_api_schema["consents"].gsub("{consentId}", "")
        uri = Ibanity.client.build_uri(path)
        list_by_uri(uri: uri, query_params: query_params)
      end

      def self.find(id:)
        path = Ibanity.consent_api_schema["consents"].gsub("{consentId}", id)
        uri = Ibanity.client.build_uri(path)
        find_by_uri(uri: uri)
      end

      def self.validate(id:, idempotency_key: nil)
        path = Ibanity.consent_api_schema["consent"]["validations"].gsub("{consentId}", id)
        uri = Ibanity.client.build_uri(path)
        create_by_uri(uri: uri, resource_type: "consent", attributes: [], idempotency_key: idempotency_key)
      end

      def self.revoke(id:, idempotency_key: nil)
        path = Ibanity.consent_api_schema["consent"]["revocations"].gsub("{consentId}", id)
        uri = Ibanity.client.build_uri(path)
        create_by_uri(uri: uri, resource_type: "consent", attributes: [], idempotency_key: idempotency_key)
      end
    end
  end
end
