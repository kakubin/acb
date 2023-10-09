# frozen_string_literal: true

RSpec.describe Acb::Custom do
  describe '.add_master_column' do
    subject { target.add_master_column(key: 'key', **options) }

    let(:target) do
      Class.new do
        include Acb::Custom
      end
    end

    let(:options) { { index: 'first.second' } }

    it 'register master_column to the register' do
      expect { target.registry.lookup('key') }.to raise_error Acb::Registry::ColumnNotFound
      subject
      master_column = target.registry.lookup('key')
      expect(master_column).to be_a Acb::MasterColumn
      options_for_master = master_column.instance_variable_get(:@options)
      expect(options_for_master).to eq(options)
    end
  end

  describe '.use' do
    subject { target.use(columns) }

    let(:target) do
      Class.new do
        include Acb::Custom

        add_master_column key: :id
        add_master_column key: :user_name, index: 'user.name'
        add_master_column key: :not_used
      end
    end

    let(:columns) do
      [
        { key: :id, name: 'id' },
        { key: :user_name, name: 'User Name' }
      ]
    end

    it 'return instance of Acb::Base' do
      exported_class = subject
      expect(exported_class).to include Acb::Base
      expect(exported_class.columns.size).to be 2
      expect(exported_class.columns.first).to be_a Acb::Column
    end
  end
end
