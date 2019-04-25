module Ibanity
  module Xs2a
    class AccountInformationAccessRequest < Ibanity::BaseResource
      def self.create_for_financial_institution(financial_institution_id:, customer_access_token:, idempotency_key: nil, meta: nil, **attributes)
        path = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["accountInformationAccessRequests"]
          .gsub("{financialInstitutionId}", financial_institution_id)
          .gsub("{accountInformationAccessRequestId}", "")
        uri = Ibanity.client.build_uri(path)
        create_by_uri(
          uri: uri,
          resource_type: "accountInformationAccessRequest",
          attributes: attributes,
          customer_access_token: customer_access_token,
          idempotency_key: idempotency_key,
          meta: meta
        )
      end

      def self.find(id:, financial_institution_id:, customer_access_token:)
        uri = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["accountInformationAccessRequests"]
          .gsub("{financialInstitutionId}", financial_institution_id)
          .gsub("{accountInformationAccessRequestId}", id)
        find_by_uri(uri: uri, customer_access_token: customer_access_token)
      end
    end
  end
end
