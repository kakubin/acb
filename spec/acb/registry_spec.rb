# frozen_string_literal: true

RSpec.describe Acb::Registry do
  describe '#lookup' do
    subject { instance.lookup(:key) }

    let(:instance) { described_class.new }

    context 'when it has a master_column' do
      before do
        master_column = Acb::MasterColumn.new(:key)
        instance.push(master_column)
      end

      it 'return instance of master_column' do
        is_expected.to be_a Acb::MasterColumn
      end
    end

    context 'when it has no master_columns' do
      it 'raise an error' do
        expect { subject }.to raise_error Acb::Registry::ColumnNotFound
      end
    end
  end
end
