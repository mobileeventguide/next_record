module NextRecord
  module ActiveRecordExtension
    def self.included(base)
      base.extend(ClassMethods)
    end

    def next
      next_record_sibling
    end

    def previous
      next_record_sibling(-1)
    end

    module ClassMethods
      def next_record_order(*order_args)
        order_args.flatten!
        define_singleton_method(:next_record_ordered) do
          order(order_args)
        end

        flush_next_record_sibling_ids = lambda { @next_record_sibling_ids = nil }
        after_create flush_next_record_sibling_ids
        after_destroy flush_next_record_sibling_ids
        after_save flush_next_record_sibling_ids
      end
    end

    private

    def next_record_sibling(offset=1)
      klass = self.class.name.underscore.pluralize.to_sym
      @next_record_sibling_ids ||=
        event.send(klass).next_record_ordered.pluck(:id)
      index = @next_record_sibling_ids.index(id)
      next_id = @next_record_sibling_ids[index+offset]
      Session.where(id: next_id).first
    end
  end
end

ActiveRecord::Base.send(:include, NextRecord::ActiveRecordExtension)
