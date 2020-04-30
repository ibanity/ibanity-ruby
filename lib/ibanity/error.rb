module Ibanity
  class Error < StandardError
    attr_reader :errors

    def initialize(errors, ibanity_request_id)
      @errors = errors
      @ibanity_request_id = ibanity_request_id
    end

    def to_s
      if @errors.is_a?(Array) && @errors.size > 0
        formatted_errors = @errors.map do |error|
          if error["meta"] && error["meta"]["attribute"]
            "* #{error["code"]}: '#{error["meta"]["attribute"]}' #{error["detail"]}"
          elsif error["meta"] && error["meta"]["resource"]
            "* #{error["code"]}: '#{error["meta"]["resource"]}' #{error["detail"]}"
          else
            "* #{error["code"]}: #{error["detail"]}"
          end
        end
        formatted_errors << "* ibanity_request_id: #{@ibanity_request_id}"
        formatted_errors.join("\n")
      elsif @errors.is_a?(Hash)
        "* #{@errors["error"]}: #{@errors["error_description"]}\n * Error hint: #{@errors["error_hint"]}\n * ibanity_request_id: #{@ibanity_request_id}"
      else
        super
      end
    end
  end
end
