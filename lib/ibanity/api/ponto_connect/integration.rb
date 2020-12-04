module Ibanity
  module PontoConnect
    class Integration < Ibanity::BaseResource
      def self.delete(client_access_token:, organization_id:)
        uri = Ibanity.ponto_connect_api_schema["organizations"]["integration"].sub("{organizationId}", organization_id)
        destroy_by_uri(uri: uri, customer_access_token: client_access_token)
      end
    end
  end
end
