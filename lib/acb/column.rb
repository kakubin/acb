# frozen_string_literal: true

module Acb
  class Column
    attr_reader :name

    def initialize(name, **options)
      @name = name
      @index = case options[:index]
               when Proc
                 options[:index]
               when String
                 options[:index].split('.')
               else
                 [name]
               end
      @format = options[:format]
    end

    def digest(row)
      data = _digest(row)
      @format && data ? format(data) : data
    end

    private

    def _digest(row)
      if @index.is_a?(Array)
        @index.reduce(row) do |acc, mthd|
          acc.send(mthd)
        end
      else
        @index.call(row)
      end
    end

    def format(data)
      case data
      when Date, Time
        data.strftime(@format)
      else
        @format % data
      end
    end
  end
end
