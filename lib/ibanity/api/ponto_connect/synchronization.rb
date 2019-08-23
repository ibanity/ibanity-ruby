module Ibanity
  module PontoConnect
    class Synchronization < Ibanity::BaseResource
      def self.create(access_token:, **attributes)
        uri = Ibanity.ponto_connect_api_schema["synchronizations"].sub("{synchronizationId}", "")
        create_by_uri(uri: uri, resource_type: "synchronization", attributes: attributes, customer_access_token: access_token)
      end

      def self.find(id:, access_token:)
        uri = Ibanity.ponto_connect_api_schema["synchronizations"].sub("{synchronizationId}", id)
        find_by_uri(uri: uri, customer_access_token: access_token)
      end
    end
  end
end
