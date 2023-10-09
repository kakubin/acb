# frozen_string_literal: true

module Acb
  module Columns
    def columns
      @_columns ||= []
    end

    def add_column(column = nil, name: nil, **options)
      column ||= Column.new(name, **options)
      columns.push(column)
    end

    def header
      columns.map(&:name)
    end

    def summarize(data)
      columns.map { |column| column.digest(data) }
    end
  end
end
