module Ibanity
  class OAuthResource < OpenStruct
    def self.create_by_uri(uri:, payload:)
      raw_item = Ibanity.client.post(uri: uri, payload: payload, json: false)
      new(raw_item)
    end

    def initialize(raw)
      super(raw)
    end
  end
end
