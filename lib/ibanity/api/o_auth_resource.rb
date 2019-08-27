module Ibanity
  class OAuthResource < OpenStruct
    def self.create_by_uri(uri:, payload:, idempotency_key: nil, headers: nil)
      raw_item = Ibanity.client.post(uri: uri, payload: payload, json: false, idempotency_key: idempotency_key, headers: headers)
      raw_item = {} if raw_item == ""
      new(raw_item)
    end

    def initialize(raw)
      super(raw)
    end
  end
end
