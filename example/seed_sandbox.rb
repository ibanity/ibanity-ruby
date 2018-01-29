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

sandbox_financial_institution = Ibanity::SandboxFinancialInstitution.create(name: "Fake Bank")
ap sandbox_financial_institution

sandbox_user = Ibanity::SandboxUser.create(login: "jhon", password: "jhon", firstName: "Jhon", lastName: "Doe")

sandbox_account = Ibanity::SandboxAccount.create(
  sandbox_user_id: sandbox_user.id,
  financial_institution_id: sandbox_financial_institution.id,
  subtype: "checking",
  relationship: "owner",
  iban: "BE123456679",
  description: "Checking account",
  currency: "EUR"
)
ap sandbox_account

sandbox_transaction = Ibanity::SandboxTransaction.create(
  sandbox_user_id: sandbox_user.id,
  financial_institution_id: sandbox_financial_institution.id,
  sandbox_account_id: sandbox_account.id,
  valueDate: "2017-05-22T00:00:00Z",
  executionDate: "2017-05-25T00:00:00Z",
  counterpart: "BE9786154282554",
  communication: "Small Cotton Shoes",
  amount: 6.99,
  currency: "EUR"
)

ap "---- Financial Institutions ------ "
ap Ibanity::FinancialInstitution.list


sandbox_users = Ibanity::SandboxUser.list

sandbox_users.each do |sandbox_user|
  ap "---- Sandbox User:  ------ "
  ap sandbox_user

  sandbox_accounts = sandbox_user.sandbox_accounts
  sandbox_accounts.each do |sandbox_account|
    ap "---- Sandbox Accounts: ------ "
    ap sandbox_account

      ap "---- Sandbox Transactions ------ "
      ap sandbox_account.sandbox_transactions
  end
end

ap Ibanity::Customer.list
ap Ibanity::Customer.list.first.accounts
ap Ibanity::Customer.list.first.accounts.first.transactions

sandbox_user = Ibanity::SandboxUser.list.first
sandbox_account = sandbox_user.sandbox_accounts.first
financial_institution = sandbox_account.financial_institution

Ibanity::SandboxTransaction.create(
  sandbox_user_id: sandbox_user.id,
  financial_institution_id: financial_institution.id,
  sandbox_account_id: sandbox_account.id,
  valueDate: "2017-05-22T00:00:00Z",
  executionDate: "2017-05-25T00:00:00Z",
  counterpart: "BE9786154282554",
  communication: "Second Transaction",
  amount: 100,
  currency: "EUR"
)
