# frozen_string_literal: true

module Acb
  module Base
    extend ActiveSupport::Concern

    class_methods do
      def columns
        @columns ||= Columns.new
      end

      def add_column(name:, **options)
        columns.push(name, **options)
      end
    end

    def to_csv(**options)
      CSV.generate(**options) do |csv|
        csv << self.class.columns.header
        data.each do |row|
          csv << get_data_from(row)
        end
      end
    end
    alias content_string to_csv

    private

    def data
      @data = @data.preload(relations) if respond_to?(:relations)
      @data.find_each
    end

    def get_data_from(row)
      self.class.columns.get_data(row)
    end
  end
end
