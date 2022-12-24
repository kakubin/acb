# frozen_string_literal: true

require_relative 'acb/version'
require 'active_support'
require 'forwardable'
require 'csv'

module Acb
  extend ActiveSupport::Concern

  autoload :Column, 'acb/column'

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
      @columns.map { |column| column.digest(row) }
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
