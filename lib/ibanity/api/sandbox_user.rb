module Ibanity
  class SandboxUser < Ibanity::BaseResource
    def self.create(attributes)
      path     = Ibanity.api_schema["sandbox"]["users"].gsub("{sandboxUserId}", "")
      uri      = Ibanity.client.build_uri(path)
      create_by_uri(uri, "sandboxUser", attributes)
    end

    def self.list(**query_params)
      uri = Ibanity.api_schema["sandbox"]["users"].sub("{sandboxUserId}", "")
      list_by_uri(uri, query_params)
    end

    def self.find(id:)
      uri = Ibanity.api_schema["sandbox"]["users"].sub("{sandboxUserId}", id)
      find_by_uri(uri)
    end

    def self.update(id:, **attributes)
      path = Ibanity.api_schema["sandbox"]["users"].sub("{sandboxUserId}", id)
      uri = Ibanity.client.build_uri(path)
      update_by_uri(uri, "sandboxUser", attributes)
    end

    def self.delete(id:)
      uri = Ibanity.api_schema["sandbox"]["users"].sub("{sandboxUserId}", id)
      destroy_by_uri(uri)
    end
  end
end
