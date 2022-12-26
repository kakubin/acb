# frozen_string_literal: true

RSpec.describe Acb::Columns do
  describe '#header' do
    subject { instance.header }

    let(:instance) { described_class.new }

    context 'if no columns' do
      it { is_expected.to eq [] }
    end

    context 'message' do
      before do
        columns = [
          Acb::Column.new('one'),
          Acb::Column.new('two')
        ]
        instance.instance_variable_set(:@columns, columns)
      end

      it { is_expected.to eq ['one', 'two'] }
    end
  end

  describe '#get_data' do
    subject { instance.get_data(target) }

    let(:instance) { described_class.new }
    let(:target) { Post.new(content: 'post content', created_at: Time.new(2022, 12, 24, 18, 0, 0)) }

    before do
      instance.push('name', index: 'content')
      instance.push('name', index: 'created_at', format: '%Y%m%d%H%M')
    end

    it { is_expected.to eq ['post content', '202212241800'] }
  end
end
