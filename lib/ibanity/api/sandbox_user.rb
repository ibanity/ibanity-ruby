module Ibanity
  class SandboxUser < Ibanity::BaseResource
    def self.create(attributes:)
      path     = Ibanity.api_schema["sandbox"]["users"].gsub("{sandboxUserId}", "")
      uri      = Ibanity.client.build_uri(path)
      create_by_uri(uri, "sandboxUser", attributes)
    end

    def self.all
      uri = Ibanity.api_schema["sandbox"]["users"].sub("{sandboxUserId}", "")
      all_by_uri(uri)
    end

    def self.find(id)
      uri = Ibanity.api_schema["sandbox"]["users"].sub("{sandboxUserId}", id)
      find_by_uri(uri)
    end

    def self.delete(id)
      uri = Ibanity.api_schema["sandbox"]["users"].sub("{sandboxUserId}", id)
      destroy_by_uri(uri)
    end
  end
end
