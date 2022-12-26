# frozen_string_literal: true

module Acb
  class Columns
    def initialize
      @columns = []
    end

    def push(name, **options)
      @columns.push(Column.new(name, **options))
    end

    def header
      @columns.map(&:name)
    end

    def get_data(row)
      @columns.map { |column| column.digest(row) }
    end
  end
end
