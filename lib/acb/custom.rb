# frozen_string_literal: true

module Acb
  module Custom
    extend ActiveSupport::Concern

    included do
      class_attribute :registry, instance_accessor: false, instance_predicate: false, default: Registry.new
    end

    module ClassMethods
      def add_master_column(key:, **options)
        registry.push(MasterColumn.new(key, **options))
      end

      def use(columns)
        klass = Class.new do
          include Acb::Base
        end

        columns.each do |column|
          master_column = registry.lookup(column[:key])
          klass.add_column(master_column.to_column(column[:name]))
        end

        klass
      end
    end
  end
end
