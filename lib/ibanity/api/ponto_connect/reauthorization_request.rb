module Ibanity
  module PontoConnect
    class ReauthorizationRequest < Ibanity::BaseResource
      def self.create(account_id:, access_token: nil, **attributes)
        uri = Ibanity.ponto_connect_api_schema["account"]["reauthorizationRequests"].gsub("{accountId}", account_id)
        create_by_uri(uri: uri, resource_type: "reauthorizationRequest", attributes: attributes, customer_access_token: access_token)
      end
    end
  end
end
