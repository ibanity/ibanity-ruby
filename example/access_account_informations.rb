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

financial_institution = Ibanity::FinancialInstitution.all.first
ap financial_institution

access_token = ENV["IBANITY_ACCESS_TOKEN"]
ap accounts = Ibanity::Account.all_for_financial_institution(financial_institution.id, access_token)
ap transactions = accounts.first.transactions(access_token)