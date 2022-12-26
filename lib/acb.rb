# frozen_string_literal: true

require_relative 'acb/version'
require 'active_support'
require 'csv'

module Acb
  extend ActiveSupport::Concern

  autoload :Column, 'acb/column'
  autoload :Columns, 'acb/columns'

  class_methods do
    def columns
      @columns ||= Columns.new
    end

    def add_column(name:, **options)
      columns.push(name, **options)
    end
  end

  def data
    @data = @data.preload(relations) if respond_to?(:relations)
    @data.find_each
  end

  def get_data_from(row)
    self.class.columns.get_data(row)
  end

  def content_string(**options)
    header_content = self.class.columns.header.join(',')

    CSV.generate(header_content, **options) do |csv|
      data.each do |row|
        csv << get_data_from(row)
      end
    end
  end
end
