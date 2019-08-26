module Ibanity
  module PontoConnect
    class Transaction < Ibanity::BaseResource
      def self.list(access_token:, account_id:, **query_params)
        uri = Ibanity.ponto_connect_api_schema["account"]["transactions"].sub("{accountId}", account_id).sub("{transactionId}", "")
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token)
      end

      def self.find(access_token:, account_id:, id:)
        uri = Ibanity.ponto_connect_api_schema["account"]["transactions"].sub("{accountId}", account_id).sub("{transactionId}", id)
        find_by_uri(uri: uri, customer_access_token: access_token)
      end
    end
  end
end
