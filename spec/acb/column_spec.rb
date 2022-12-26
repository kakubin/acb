# frozen_string_literal: true

RSpec.describe Acb::Column do
  describe '#digest' do
    subject { instance.digest(target) }

    let(:instance) { described_class.new('content', **options) }

    let(:target) { Post.new(content: 'post content', created_at: Time.new(2022, 12, 24, 18, 0, 0)) }

    before do
      target.comments.new(content: 'comment content')
    end

    context 'if index is a typeof string' do
      let(:options) { { index: 'content' } }

      it { is_expected.to eq 'post content' }
    end

    context 'if index is a typeof lambda' do
      context 'when comments exists' do
        let(:options) { { index: ->(target) { target.comments.first&.content } } }

        it { is_expected.to eq 'comment content' }
      end

      context 'when index of array is out of range' do
        let(:options) { { index: ->(target) { target.comments[1]&.content } } }

        it { is_expected.to be_nil }
      end
    end

    context 'when index is not passed' do
      let(:options) { {} }

      it 'use name instead of index' do
        is_expected.to eq 'post content'
      end
    end

    context 'when formatting Time' do
      let(:options) { { index: 'created_at', format: '%Y/%m/%d %H/%M' } }

      it { is_expected.to eq '2022/12/24 18/00' }
    end

    context 'when formatting String' do
      let(:options) { { index: 'content', format: 'Content: %s' } }

      it { is_expected.to eq 'Content: post content' }
    end
  end
end
