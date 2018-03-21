module Ibanity
  class Error < StandardError
    attr_reader :errors

    def initialize(errors)
      @errors = errors
    end

    def to_s
      if @errors && @errors.size > 0
        @errors.map do |error|
          if error["attribute"]
            "* #{error["code"]}: '#{error["attribute"]}' #{error["message"]}"
          else
            "* #{error["code"]}: #{error["message"]}"
          end
        end.join("\n")
      else
        super
      end
    end
  end
end
