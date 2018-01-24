module Ibanity
  class Transaction < Ibanity::BaseResource
    def self.all_for_customer_account(customer_id, account_id)
      uri = Ibanity.api_schema["customerAccountTransactions"]
        .sub("{customerId}", customer_id)
        .sub("{accountId}", account_id)
        .sub("{transactionId}", "")
      all_by_uri(uri)
    end

    def self.all(financial_institution_id:, account_id:, customer_access_token:)
      uri = Ibanity.api_schema["customer"]["financialInstitution"]["transactions"]
        .sub("{financialInstitutionId}", financial_institution_id)
        .sub("{accountId}", account_id)
        .sub("{transactionId}", "")
      all_by_uri(uri, customer_access_token)
    end

    def self.get(id:, financial_institution_id:, account_id:, customer_access_token:)
      uri = Ibanity.api_schema["customer"]["financialInstitution"]["transactions"]
        .sub("{financialInstitutionId}", financial_institution_id)
        .sub("{accountId}", account_id)
        .sub("{transactionId}", id)
      find_by_uri(uri, customer_access_token)
    end
  end
end
