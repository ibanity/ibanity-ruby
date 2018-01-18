require_relative "../lib/ibanity"
require "awesome_print"
require "date"
require "json"

Ibanity.configure do |config|
  config.certificate    = ENV["IBANITY_CERTIFICATE"]
  config.key            = ENV["IBANITY_KEY"]
  config.key_passphrase = ENV["IBANITY_PASSPHRASE"]
  config.api_host       = ENV["IBANITY_API_HOST"]
  config.ssl_ca_file    = ENV["IBANITY_SSL_CA_FILE"]
end

ap Ibanity.api_schema
# financial_institution = Ibanity::FinancialInstitution.all.first
# ap financial_institution

# ap Ibanity::AccessToken.create_for_financial_institution(
#   financial_institution_id: "f4b55ee4-5517-465c-8abc-231bff16659a", attributes: { authorizationCode: "dbe216dd-7326-490b-b842-e63156ef0638" })

access_token = ENV["IBANITY_ACCESS_TOKEN"]
# ap accounts = Ibanity::Account.all_for_financial_institution(financial_institution.id, access_token)
# ap transactions = accounts.first.transactions(access_token

ap Ibanity::AccountInformationAccessRequest.create_for_financial_institution(
  financial_institution_id: "f4b55ee4-5517-465c-8abc-231bff16659a",
  access_token: access_token,
  attributes: { redirectUri: "http://localhost/test-confirmation" }
)
ap Ibanity::FundAvailabilityAccessRequest.create_for_financial_institution(
  financial_institution_id: "f4b55ee4-5517-465c-8abc-231bff16659a",
  access_token: access_token,
  attributes: { redirectUri: "http://localhost/test-confirmation" }
)
ap Ibanity::PaymentInitiationRequest.create_for_financial_institution(
  financial_institution_id: "f4b55ee4-5517-465c-8abc-231bff16659a",
  access_token: access_token,
  attributes: {  
    creditorName:    "John Doe",
    creditorAccount: "BE11234532",
    amount:          100.01,
    communication:   "Invoice 23", 
    currency:        "EUR"
  }
)