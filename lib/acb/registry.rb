# frozen_string_literal: true

module Acb
  class Registry
    class ColumnNotFound < StandardError; end

    def initialize
      @registrations = []
    end

    def push(master_column)
      @registrations.push(master_column)
    end

    def lookup(key)
      @registrations.find { |registration| registration.key == key } or raise ColumnNotFound
    end
  end
end
