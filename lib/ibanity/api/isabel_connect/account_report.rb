module Ibanity
  module IsabelConnect
    class AccountReport < Ibanity::BaseResource
      def self.list(access_token:, headers: nil, **query_params)
        uri = Ibanity.isabel_connect_api_schema["accountReports"].sub("{accountReportId}", "")
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token, headers: headers)
      end

      def self.find(id:, access_token:)
        uri = Ibanity.isabel_connect_api_schema["accountReports"].sub("{accountReportId}", id)
        find_file_by_uri(uri: uri, customer_access_token: access_token, headers: { accept: "text/plain" })
      end
    end
  end
end
