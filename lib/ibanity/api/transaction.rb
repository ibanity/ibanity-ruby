module Ibanity
  class Transaction < Ibanity::BaseResource
    def self.all_for_customer_account(customer_id, account_id)
      uri = Ibanity.api_schema["customerAccountTransactions"]
        .sub("{customerId}", customer_id)
        .sub("{accountId}", account_id)
        .sub("{transactionId}", "")
      all_by_uri(uri)
    end
  end
end
