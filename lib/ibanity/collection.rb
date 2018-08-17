module Ibanity
  class Collection < DelegateClass(Array)
    attr_accessor :page_limit, :before_cursor, :after_cursor, :first_link, :next_link, :previous_link

    def initialize(klass:, items:, paging:, links:, customer_access_token: nil)
      paging        ||= {}
      links         ||= {}
      @klass          = klass
      @page_limit     = paging["limit"]
      @before_cursor  = paging["before"]
      @after_cursor   = paging["after"]
      @first_link     = links["first"]
      @next_link      = links["next"]
      @previous_link  = links["prev"]
      super(items)
    end

    def inspect
      result = "#<#{self.class.name}"
      instance_variables.each do |instance_variable|
        result +=" #{instance_variable}=#{instance_variable_get(instance_variable).inspect}"
      end
      result += ">"
      result
    end
  end
end
