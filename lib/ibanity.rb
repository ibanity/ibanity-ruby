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
require_relative "ibanity/api/financial_institution"
require_relative "ibanity/api/account_information_access_request"
require_relative "ibanity/api/payment_initiation_request"
require_relative "ibanity/api/fund_availability_access_request"
require_relative "ibanity/api/sandbox_account"
require_relative "ibanity/api/sandbox_transaction"
require_relative "ibanity/api/sandbox_user"
require_relative "ibanity/api/sandbox_financial_institution"
require_relative "ibanity/api/customer_access_token"

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
      @api_schema ||= client.get(client.base_uri)["links"]
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
