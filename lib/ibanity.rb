require "ostruct"
require "openssl"
require "uri"
require "rest_client"
require "json"

require_relative "ibanity/util"
require_relative "ibanity/error"
require_relative "ibanity/client"
require_relative "ibanity/api/base_resource"
require_relative "ibanity/api/customer"
require_relative "ibanity/api/account"
require_relative "ibanity/api/transaction"
require_relative "ibanity/api/authorization"
require_relative "ibanity/api/financial_institution"
require_relative "ibanity/api/synchronization"
require_relative "ibanity/api/sandbox_account"
require_relative "ibanity/api/sandbox_transaction"
require_relative "ibanity/api/sandbox_user"

module Ibanity
  class << self
    def client
      options = configuration.to_h.delete_if { |_, v| v.nil? }
      @client ||= Ibanity::Client.new(options)
    end

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Struct.new(
        :certificate,
        :key,
        :key_passphrase,
        :api_scheme,
        :api_host,
        :api_port,
        :ssl_ca_file
      ).new
    end

    def api_schema
      @urls ||= {
        "customers"                    => "#{client.base_uri}/customers/{customerId}",
        "customerAccounts"             => "#{client.base_uri}/customers/{customerId}/accounts/{accountId}",
        "applicationAccounts"          => "#{client.base_uri}/accounts",
        "applicationTransactions"      => "#{client.base_uri}/transactions",
        "customerAccountTransactions"  => "#{client.base_uri}/customers/{customerId}/accounts/{accountId}/transactions/{transactionId}",
        "financialInstitutions"        => "#{client.base_uri}/financial-institutions/{financialInstitutionId}",
        "customerAuthorizations"       => "#{client.base_uri}/customers/{customerId}/authorizations/{authorizationId}",
        "customerSynchronizations"     => "#{client.base_uri}/customers/{customerId}/synchronizations/{authorizationId}",
        "sandbox"                      => {
          "financialInstitutions" => "#{client.base_uri}/sandbox/financial-institutions/{financialInstitutionId}",
          "users"                 => "#{client.base_uri}/sandbox/users/{sandboxUserId}",
          "accounts"              => "#{client.base_uri}/sandbox/financial-institutions/{financialInstitutionId}/users/{sandboxUserId}/accounts/{sandboxAccountId}",
          "transactions"          => "#{client.base_uri}/sandbox/financial-institutions/{financialInstitutionId}/users/{sandboxUserId}/accounts/{sandboxAccountId}/transactions/{sandboxTransactionId}"
        }
      }
    end

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private)
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        client.__send__(method_name, *args, &block)
      else
        super
      end
    end
  end
end
