module Ibanity
  module PontoConnect
    class Account < Ibanity::BaseResource
      def self.list(access_token:, **query_params)
        uri = Ibanity.ponto_connect_api_schema["accounts"].sub("{accountId}", "")
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token)
      end

      def self.find(access_token:, id:)
        uri = Ibanity.ponto_connect_api_schema["accounts"].sub("{accountId}", id)
        find_by_uri(uri: uri, customer_access_token: access_token)
      end

      def self.delete(access_token:, id:)
        uri = Ibanity.ponto_connect_api_schema["accounts"].sub("{accountId}", id)
        destroy_by_uri(uri: uri, customer_access_token: access_token)
      end
    end
  end
end
