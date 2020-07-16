module Ibanity
  module Util
    def self.underscorize(obj)
      case obj
      when Array
        obj.map { |e| underscorize(e) }
      when Hash
        obj.keys.reduce({}) do |result, key|
          result[underscore(key)] = underscorize(obj[key])
          result
        end
      else
        obj
      end
    end

    def self.underscore(camel_cased_word)
      return camel_cased_word unless camel_cased_word =~ /[A-Z-]/
      word = camel_cased_word.to_s.gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end

    def self.camelize(string, uppercase_first_letter = true)
      string = if uppercase_first_letter
                 string.sub(/^[a-z\d]*/) { $&.capitalize }
               else
                 string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
               end
      string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}" }.gsub("/", "::")
    end
  end
end
