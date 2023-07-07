require "ostruct"
require "openssl"
require "uri"
require "rest_client"
require "json"
require "securerandom"
require "jose"

require_relative "ibanity/util"
require_relative "ibanity/error"
require_relative "ibanity/collection"
require_relative "ibanity/client"
require_relative "ibanity/http_signature"
require_relative "ibanity/webhook"

require_relative "ibanity/api/base_resource"
require_relative "ibanity/api/flat_resource"

require_relative "ibanity/api/o_auth_resource"

require_relative "ibanity/api/consent"
require_relative "ibanity/api/isabel_connect"
require_relative "ibanity/api/webhooks"
require_relative "ibanity/api/xs2a"

module Ibanity
  class << self
    def client
      options = configuration.to_h.delete_if { |_, v| v.nil? }
      @client ||= Ibanity::Client.new(**options)
    end

    def configure
      @client                    = nil
      @xs2a_api_schema           = nil
      @isabel_connect_api_schema = nil
      @consent_api_schema        = nil
      @ponto_connect_api_schema  = nil
      @webhooks_api_schema       = nil
      @sandbox_api_schema        = nil
      @configuration             = nil
      yield configuration
    end

    def configuration
      @configuration ||= Struct.new(
        :certificate,
        :key,
        :key_passphrase,
        :signature_certificate,
        :signature_certificate_id,
        :signature_key,
        :signature_key_passphrase,
        :isabel_connect_client_id,
        :isabel_connect_client_secret,
        :ponto_connect_client_id,
        :ponto_connect_client_secret,
        :api_scheme,
        :api_host,
        :ssl_ca_file,
        :application_id,
        :debug_http_requests,
        :timeout
      ).new
    end

    def xs2a_api_schema
      @xs2a_api_schema ||= client.get(uri: "#{client.base_uri}/xs2a")["links"]
    end

    def sandbox_api_schema
      @sandbox_api_schema ||= client.get(uri: "#{client.base_uri}/sandbox")["links"]
    end

    def isabel_connect_api_schema
      @isabel_connect_api_schema ||= client.get(uri: "#{client.base_uri}/isabel-connect")["links"]
    end

    def ponto_connect_api_schema
      @ponto_connect_api_schema ||= client.get(uri: "#{client.base_uri}/ponto-connect")["links"]
    end

    def consent_api_schema
      @consent_api_schema ||= client.get(uri: "#{client.base_uri}/consent")["links"]
    end

    def webhooks_api_schema
      @webhooks_api_schema ||= client.get(uri: "#{client.base_uri}/webhooks")["links"]
    end

    def webhook_keys
      @webhook_keys ||= Ibanity::Webhooks::Key.list
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
