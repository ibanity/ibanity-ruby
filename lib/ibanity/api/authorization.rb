module Ibanity
  class Authorization < Ibanity::BaseResource
    def self.destroy(client, customer_id, id)
      uri = client.build_uri(path.gsub(":customer_id", customer_id).gsub(":authorization_id", id))
      client.delete(uri)
    end

    def destroy
      self.class.destroy(client, customer_id, id)
    end
  end
end
