module Ibanity
  module IsabelConnect
    class Transaction < Ibanity::BaseResource
      def self.list(account_id:, access_token:, headers: nil, **query_params)
        uri = Ibanity.isabel_connect_schema["account"]["transactions"].sub("{accountId}", account_id)
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token, headers: headers)
      end
    end
  end
end
