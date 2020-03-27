module Ibanity
  module PontoConnect
    class FinancialInstitution < Ibanity::BaseResource
      def self.list(access_token: nil, **query_params)
        uri = Ibanity.ponto_connect_api_schema["financialInstitutions"].sub("{financialInstitutionId}", "")
        list_by_uri(uri: uri, query_params: query_params, customer_access_token: access_token)
      end

      def self.find(access_token: nil, id:)
        uri = Ibanity.ponto_connect_api_schema["financialInstitutions"].sub("{financialInstitutionId}", id)
        find_by_uri(uri: uri, customer_access_token: access_token)
      end
    end
  end
end
