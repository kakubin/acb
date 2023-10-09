# frozen_string_literal: true

require_relative 'acb/version'
require 'active_support'
require 'csv'

module Acb
  extend ActiveSupport::Concern

  autoload :Base, 'acb/base'
  autoload :Column, 'acb/column'
  autoload :Columns, 'acb/columns'
  autoload :Custom, 'acb/custom'
  autoload :MasterColumn, 'acb/master_column'
  autoload :Registry, 'acb/registry'

  include Base
end
