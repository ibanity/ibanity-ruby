module Ibanity
  module Webhooks
    class Key < Ibanity::FlatResource
      def self.list
        path = Ibanity.webhooks_api_schema["keys"]
        uri = Ibanity.client.build_uri(path)
        list_by_uri(uri: uri, key: "keys")
      end
    end
  end
end
