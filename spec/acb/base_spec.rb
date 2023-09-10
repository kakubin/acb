# frozen_string_literal: true

RSpec.describe Acb::Base do
  describe '#to_csv' do
    subject { target.to_csv }

    let(:klass) do
      Class.new do
        include Acb::Base

        add_column name: 'id'
        add_column name: 'User Name', index: 'user.name'
        add_column name: 'created_at', format: '%Y-%m-%d'
        add_column name: 'Comment Amount', index: 'comments.size'
        add_column name: 'First Comment', index: ->(post) { post.comments.first.content }

        def initialize
          @data = Post.all
        end

        def relations
          %i[user comments]
        end
      end
    end
    let(:target) { klass.new }

    it { is_expected.to be_a String }

    it { expect(subject.count("\n")).to be 51 }
  end
end
