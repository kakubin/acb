# frozen_string_literal: true

require 'acb'
require 'active_record'

conn = { adapter: 'sqlite3', database: ':memory:' }
ActiveRecord::Base.establish_connection(conn)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
