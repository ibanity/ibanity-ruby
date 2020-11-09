module Ibanity
  module Xs2a
    class FinancialInstitutionCountry < Ibanity::BaseResource
      def self.list(**query_params)
        uri = Ibanity.xs2a_api_schema["financialInstitutionCountries"]
        list_by_uri(uri: uri, query_params: query_params)
      end
    end
  end
end
