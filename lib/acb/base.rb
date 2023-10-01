# frozen_string_literal: true

module Acb
  module Base
    extend ActiveSupport::Concern

    module ClassMethods
      include Columns
    end

    def to_csv(**options)
      CSV.generate(**options) do |csv|
        csv << self.class.header
        data.each do |row|
          csv << summarize(row)
        end
      end
    end
    alias content_string to_csv

    private

    def data
      @data = @data.preload(relations) if respond_to?(:relations)
      @data.find_each
    end

    def summarize(row)
      self.class.summarize(row)
    end
  end
end
