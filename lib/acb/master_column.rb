# frozen_string_literal: true

module Acb
  class MasterColumn
    attr_reader :key

    def initialize(key, **options)
      @key = key.to_sym
      @options = options
    end

    def to_column(name)
      Column.new(name, **@options)
    end
  end
end
