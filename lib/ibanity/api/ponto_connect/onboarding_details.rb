module Ibanity
  module PontoConnect
    class OnboardingDetails < Ibanity::BaseResource
      def self.create(client_access_token:, **attributes)
        uri = Ibanity.ponto_connect_api_schema["onboardingDetails"]
        create_by_uri(uri: uri, resource_type: "onboardingDetails", attributes: attributes, customer_access_token: client_access_token)
      end
    end
  end
end
