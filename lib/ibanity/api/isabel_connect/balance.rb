module Ibanity
  module IsabelConnect
    class Balance < Ibanity::BaseResource
      def self.list(account_id:, access_token:, headers: nil, **query_params)
        Ibanity.isabel_connect_api_schema["accounts"]["balances"]
        uri = Ibanity.isabel_connect_api_schema["account"]["balances"].sub("{accountId}", account_id)
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token, headers: headers)
      end
    end
  end
end
