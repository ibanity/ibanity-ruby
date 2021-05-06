module Ibanity
  class BaseResource < OpenStruct
    def self.create_by_uri(uri:, resource_type:, attributes:, customer_access_token: nil, idempotency_key: nil, meta: nil)
      payload = {
        data: {
          type:       resource_type,
          attributes: attributes
        }
      }
      payload[:data][:meta] = meta if meta
      raw_item = Ibanity.client.post(uri: uri, payload: payload, customer_access_token: customer_access_token, idempotency_key: idempotency_key)
      new(raw_item["data"], customer_access_token)
    end

    def self.list_by_uri(uri:, query_params: {}, customer_access_token: nil, headers: nil)
      raw_response = Ibanity.client.get(uri: uri, query_params: query_params, headers: headers, customer_access_token: customer_access_token)
      items        = raw_response["data"].map do |raw_item|
        new(raw_item, customer_access_token)
      end
      Ibanity::Collection.new(
        klass:                  self,
        items:                  items,
        links:                  raw_response["links"],
        paging:                 raw_response.dig("meta", "paging"),
        synchronized_at:        raw_response.dig("meta", "synchronizedAt"),
        latest_synchronization: raw_response.dig("meta", "latestSynchronization"),
      )
    end

    def self.find_by_uri(uri:, customer_access_token: nil, headers: nil)
      new(find_raw_by_uri(uri: uri, customer_access_token: customer_access_token, headers: headers), customer_access_token)
    end

    def self.find_raw_by_uri(uri:, customer_access_token: nil, headers: nil)
      raw_item = Ibanity.client.get(uri: uri, customer_access_token: customer_access_token, headers: headers)
      raw_item["data"]
    end

    def self.destroy_by_uri(uri:, customer_access_token: nil)
      raw_item = Ibanity.client.delete(uri: uri, customer_access_token: customer_access_token)
      new(raw_item["data"], customer_access_token)
    end

    def self.update_by_uri(uri:, resource_type:, attributes:, customer_access_token: nil, idempotency_key: nil)
      payload = {
        data: {
          type: resource_type,
          attributes: attributes
        }
      }
      raw_item = Ibanity.client.patch(uri: uri, payload: payload, customer_access_token: customer_access_token, idempotency_key: idempotency_key)
      new(raw_item["data"])
    end

    def self.find_file_by_uri(uri:, customer_access_token: nil, headers: nil)
      Ibanity.client.get(uri: uri, customer_access_token: customer_access_token, headers: headers)
    end

    def self.create_file_by_uri(uri:, resource_type:, raw_content:, customer_access_token: nil, idempotency_key: nil, headers: nil)
      raw_item = Ibanity.client.post(uri: uri, payload: raw_content, customer_access_token: customer_access_token, idempotency_key: idempotency_key, json: false, headers: headers)
      new(raw_item["data"], customer_access_token)
    end

    def initialize(raw, customer_access_token = nil)
      attributes = prepare_attributes(raw)
      super(attributes)

      relationships = raw["relationships"] || {}
      setup_relationships(relationships, customer_access_token)

      links = raw["links"] || {}
      setup_links(links)

      meta = raw["meta"] || {}
    end

    def reload!
      reloaded   = self.class.find_raw_by_uri(uri)
      attributes = prepare_attributes(reloaded)
      attributes.each do |key, value|
        self[key] = value
      end
      self
    end

    private

    def prepare_attributes(raw)
      base = {
        "id"  => raw["id"],
      }
      attributes           = raw["attributes"]    || {}
      meta                 = raw["meta"]          || {}
      params               = base.merge(attributes).merge(meta)
      Ibanity::Util.underscorize(params)
    end

    def setup_relationships(relationships, customer_access_token = nil)
      relationships.each do |key, relationship|
        url = relationship.dig("links", "related")
        id = relationship.dig("data", "id")

        if url
          setup_relationship(customer_access_token, key, relationship, url)
        elsif id
          self[Ibanity::Util.underscore("#{key}_id")] = id
        end
      end
    end

    def setup_relationship(customer_access_token, key, relationship, url)
      if relationship["data"]
        resource = relationship.dig("data", "type") || key
        klass = relationship_klass(resource)
        method_name = Ibanity::Util.underscore(key)
        define_singleton_method(method_name) do |headers: nil|
          klass.find_by_uri(uri: url, headers: headers, customer_access_token: customer_access_token)
        end
        self[Ibanity::Util.underscore("#{key}_id")] = relationship.dig("data", "id")
      elsif relationship["meta"]
        resource = relationship.dig("meta", "type")
        klass = relationship_klass(resource)
        method_name = Ibanity::Util.underscore(key)
        define_singleton_method(method_name) do |headers: nil|
          klass.find_by_uri(uri: url, headers: headers, customer_access_token: customer_access_token)
        end
      else
        resource = key
        singular_resource = resource[0..-2]
        klass = relationship_klass(singular_resource)
        method_name = Ibanity::Util.underscore(resource)
        define_singleton_method(method_name) do |headers: nil, **query_params|
          klass.list_by_uri(uri: url, headers: headers, query_params: query_params, customer_access_token: customer_access_token)
        end
      end
    end

    def setup_links(links)
      links.each do |key, link|
        self[Ibanity::Util.underscore("#{key}_link")] = link
      end
    end

    def relationship_klass(name)
      camelized_name = Ibanity::Util.camelize(name)
      enclosing_module =
        if camelized_name == "FinancialInstitution"
          Ibanity::Xs2a
        else
          Object.const_get(self.class.to_s.split("::")[0...-1].join("::"))
        end

      enclosing_module.const_get(camelized_name)
    end
  end
end
