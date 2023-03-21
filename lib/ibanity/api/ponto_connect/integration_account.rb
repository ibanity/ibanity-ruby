module Ibanity
  module PontoConnect
    class IntegrationAccount < Ibanity::BaseResource
      def self.list(client_access_token:, **query_params)
        uri = Ibanity.ponto_connect_api_schema["integrationAccounts"].sub("{integrationAccountId}", "")
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: client_access_token)
      end
    end
  end
end
