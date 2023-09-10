# frozen_string_literal: true

module Acb
  module Custom
    extend ActiveSupport::Concern
    include Base

    included do
      class_attribute :registry, instance_accessor: false, instance_predicate: false, default: Registry.new
    end

    class_methods do
      def add_master_column(key:, **options)
        registry.push(MasterColumn.new(key.to_sym, **options))
      end
    end

    private

    def use_columns(columns)
      columns.each do |column|
        master_column = self.class.registry.lookup(column[:key].to_sym)
        self.class.add_column(master_column.to_column(column[:name]))
      end
    end
  end
end
