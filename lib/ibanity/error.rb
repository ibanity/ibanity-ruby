module Ibanity
  class Error < StandardError
    attr_reader :errors

    def initialize(errors)
      @errors = errors
    end

    def to_s
      if @errors && @errors.size > 0
        @errors.map do |error|
          p error
          if error["meta"] && error["meta"]["attribute"]
            "* #{error["code"]}: '#{error["meta"]["attribute"]}' #{error["detail"]}"
          elsif error["meta"] && error["meta"]["resource"]
            "* #{error["code"]}: '#{error["meta"]["resource"]}' #{error["detail"]}"
          else
            "* #{error["code"]}: #{error["detail"]}"
          end
        end.join("\n")
      else
        super
      end
    end
  end
end
