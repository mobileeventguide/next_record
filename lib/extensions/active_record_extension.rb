module NextRecord
  module ActiveRecordExtension
    def self.included(base)
      base.extend(ClassMethods)
    end

    def next
      next_record
    end

    def previous
      next_record(-1)
    end

    module ClassMethods
      attr_reader :next_record_options

      def next_record_order(*args)
        args.flatten!
        @next_record_options = (args.last.is_a?(Hash) ? args.pop : {})
        define_singleton_method(:next_record_ordered) do
          order(args)
        end
      end
    end

    private

    def next_record(offset=1)
      relation = self.class.next_record_ordered
      scope = self.class.next_record_options[:scope]
      if scope
        relation = relation.where(scope => send(scope))
      end
      ids = relation.pluck(:id)
      index = ids.index(id) + offset
      return nil if index < 0 || index >= ids.size
      next_id = ids[index]
      relation.where(id: next_id).first
    end
  end
end

ActiveRecord::Base.send(:include, NextRecord::ActiveRecordExtension)

