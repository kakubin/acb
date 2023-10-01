# frozen_string_literal: true

module Acb
  module Columns
    def columns
      @_columns ||= []
    end

    def add_column(name:, **options)
      columns.push(Column.new(name, **options))
    end

    def header
      columns.map(&:name)
    end

    def summarize(data)
      columns.map { |column| column.digest(data) }
    end
  end
end
