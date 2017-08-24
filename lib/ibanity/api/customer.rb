module Ibanity
  class Customer < Ibanity::BaseResource
    def self.all
      uri = Ibanity.api_schema["customers"].sub("{customerId}", "")
      all_by_uri(uri)
    end

    def self.find(id)
      uri = Ibanity.api_schema["customers"].sub("{customerId}", id)
      find_by_uri(uri)
    end

    def self.destroy(id)
      uri = Ibanity.api_schema["customers"].sub("{customerId}", id)
      destroy_by_uri(uri)
    end
  end
end
