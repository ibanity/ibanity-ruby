module Ibanity
  class FlatResource < OpenStruct
    def self.list_by_uri(uri:, key:)
      raw_response = Ibanity.client.get(uri: uri)
      items = raw_response[key].map { |raw_item| new(raw_item) }
      Ibanity::Collection.new(
        klass:                  self,
        items:                  items,
        links:                  nil,
        paging:                 nil,
        synchronized_at:        nil,
        latest_synchronization: nil
      )
    end

    def initialize(raw)
      super(raw)
    end
  end
end
