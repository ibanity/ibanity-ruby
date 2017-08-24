module Ibanity
  class Synchronization < Ibanity::BaseResource
    def self.create(customer_id)
      path     = Ibanity.api_schema["customerSynchronizations"]
        .gsub("{customerId}", customer_id)
        .gsub("{authorizationId}", "")
      uri      = Ibanity.client.build_uri(path)
      raw_item = Ibanity.client.post(uri, {})
      new(raw_item["data"])
    end

    def self.create_and_wait(customer_id)
      synchronization = create(customer_id)
      count = 0
      while count < 120 && (synchronization.status == "pending" || synchronization.status == "running")
        synchronization.reload!
        count += 1
        sleep 1
      end
      synchronization
    end
  end
end
