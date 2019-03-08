module Ibanity
  class OAuthResource < OpenStruct
    def self.create_by_uri(uri:, payload:, idempotency_key: nil)
      raw_item = Ibanity.client.post(uri: uri, payload: payload, json: false, idempotency_key: idempotency_key)
      new(raw_item)
    end

    def initialize(raw)
      super(raw)
    end
  end
end
