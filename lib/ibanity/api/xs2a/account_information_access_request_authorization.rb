module Ibanity
  module Xs2a
    class AccountInformationAccessRequestAuthorization < Ibanity::BaseResource
      def self.create(financial_institution_id:, account_information_access_request_id:, customer_access_token:, idempotency_key: nil, meta: nil, **attributes)
        path = Ibanity.xs2a_api_schema["customer"]["financialInstitution"]["accountInformationAccessRequest"]["authorizations"]
                   .gsub("{financialInstitutionId}", financial_institution_id)
                   .gsub("{accountInformationAccessRequestId}", account_information_access_request_id)
                   .gsub("{authorizationId}", "")
        uri = Ibanity.client.build_uri(path)
        create_by_uri(
            uri: uri,
            resource_type: "authorization",
            attributes: attributes,
            customer_access_token: customer_access_token,
            idempotency_key: idempotency_key,
            meta: meta
        )
      end
    end
  end
end
