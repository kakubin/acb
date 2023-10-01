# frozen_string_literal: true

RSpec.describe Acb::Columns do
  describe '#header' do
    subject { instance.header }

    let(:instance) { klass.new }
    let(:klass) do
      Class.new do
        include Acb::Columns
      end
    end

    context 'when no columns' do
      it { is_expected.to eq [] }
    end

    context 'when several columns added' do
      before do
        instance.add_column(name: 'one')
        instance.add_column(name: 'two')
      end

      it { is_expected.to eq ['one', 'two'] }
    end
  end

  describe '#add_column' do
    subject { instance.add_column(name: 'name', **options) }

    let(:instance) { klass.new }
    let(:klass) do
      Class.new do
        include Acb::Columns
      end
    end

    let(:options) { {} }

    it 'add an instance of Acb::Column' do
      expect { subject }.to change(instance.columns, :count).by(1)
      expect(instance.columns.last).to be_a Acb::Column
    end

    context 'when options for Column given' do
      let(:options) { { index: 'key_name' } }
      it 'is reflected to Column instance' do
        expect { subject }.to change(instance.columns, :count).by(1)
        expect(instance.columns.last.instance_variable_get(:@index)).to eq ['key_name']
      end
    end
  end

  describe '#summarize' do
    subject { instance.summarize(target) }

    let(:instance) { klass.new }
    let(:klass) do
      Class.new do
        include Acb::Columns
      end
    end
    let(:target) { Post.new(content: 'post content', created_at: Time.new(2022, 12, 24, 18, 0, 0)) }

    before do
      instance.add_column(name: 'name', index: 'content')
      instance.add_column(name: 'name', index: 'created_at', format: '%Y%m%d%H%M')
    end

    it { is_expected.to eq ['post content', '202212241800'] }
  end
end
