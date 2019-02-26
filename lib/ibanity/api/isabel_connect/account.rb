module Ibanity
  module IsabelConnect
    class Account < Ibanity::BaseResource
      def self.list(access_token:, headers: nil, **query_params)
        uri = Ibanity.api_schema[:isabel_connect]["accounts"].sub("{accountId}", "")
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token, headers: headers)
      end

      def self.find(id:, access_token:, headers: nil)
        uri = Ibanity.api_schema[:isabel_connect]["accounts"]
          .sub("{accountId}", id)
        find_by_uri(uri: uri, customer_access_token: access_token, headers: headers)
      end
    end
  end
end
