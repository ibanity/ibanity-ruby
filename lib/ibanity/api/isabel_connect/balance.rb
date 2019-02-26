module Ibanity
  module IsabelConnect
    class Balance < Ibanity::BaseResource
      def self.list(account_id:, access_token:, headers: nil, **query_params)
        p Ibanity.api_schema[:isabel_connect]["accounts"]["balances"]
        uri = Ibanity.api_schema[:isabel_connect]["account"]["balances"].sub("{accountId}", account_id).sub("{balanceId}", "")
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token, headers: headers)
      end
    end
  end
end
