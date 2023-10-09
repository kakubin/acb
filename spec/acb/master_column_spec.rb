# frozen_string_literal: true

RSpec.describe Acb::MasterColumn do
  describe '#initialize' do
    subject { described_class.new(key) }

    context 'when key is string' do
      let(:key) { 'key' }

      it 'is converted to symbol' do
        instance = subject
        expect(instance.key).to be 'key'
      end
    end
  end

  describe '#to_column' do
    subject { instance.to_column('name') }

    let(:instance) { described_class.new(:key) }

    it 'is converted to a instance of Acb::Column' do
      result = subject
      expect(result).to be_a Acb::Column
      expect(result.name).to eq 'name'
    end
  end
end
