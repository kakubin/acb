# frozen_string_literal: true

require_relative 'acb/version'
require 'active_support'
require 'forwardable'

module Acb
  extend ActiveSupport::Concern

  class Header
    extend Forwardable
    include Enumerable

    attr_accessor :columns

    def_delegator :@columns, :each

    def initialize
      @columns = []
    end

    def push(name, **options)
      @columns.push(Column.new(name, **options))
    end

    def keys
      @columns.map(&:name)
    end

    def get_data(row)
      @columns.map { _1.digest(row) }
    end
  end

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

    def _digest(row)
      if @index.is_a?(Array)
        @index.reduce(row) do |acc, set|
          acc.send(set)
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

  class_methods do
    def header
      @header ||= Header.new
    end

    def add_column(name:, **options)
      header.push(name, **options)
    end
  end

  def initialize(options = {})
    @options = options
  end

  def data
    @data = @data.preload(relations) if respond_to?(:relations)
    @data.find_each
  end

  def header
    self.class.header.keys
  end

  def get_data_from(row)
    self.class.header.get_data(row)
  end

  def content_string
    header_content = header.join(',')

    CSV.generate(header_content, **@options) do |csv|
      data.each do |row|
        csv << get_data_from(row)
      end
    end
  end
end
