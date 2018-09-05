module Ibanity
  class Collection < DelegateClass(Array)
    attr_accessor :page_limit,
      :before_cursor,
      :after_cursor,
      :first_link,
      :next_link,
      :previous_link,
      :latest_synchronization,
      :synchronized_at

    def initialize(
      klass:,
      items:,
      paging:,
      links:,
      synchronized_at:,
      latest_synchronization:
    )
      paging                ||= {}
      links                 ||= {}
      @klass                  = klass
      @page_limit             = paging["limit"]
      @before_cursor          = paging["before"]
      @after_cursor           = paging["after"]
      @first_link             = links["first"]
      @next_link              = links["next"]
      @previous_link          = links["prev"]
      @synchronized_at        = synchronized_at
      @latest_synchronization = latest_synchronization
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
