# frozen_string_literal: true

RSpec.describe Acb do
  it 'has a version number' do
    expect(Acb::VERSION).not_to be nil
  end

  describe '#content_string' do
    subject { target.content_string }

    let(:klass) do
      Class.new do
        include Acb

        add_column name: 'id'
        add_column name: 'User Name', index: 'user.name'
        add_column name: 'created_at', format: '%Y-%m-%d'
        add_column name: 'Comment Amount', index: 'comments.size'
        add_column name: 'First Comment', index: ->(post) { post.comments.first.content }

        def initialize
          @data = Post.all
          super()
        end

        def relations
          [:user, :comments]
        end
      end
    end
    let(:target) { klass.new }

    it { is_expected.to be_a String }
  end
end
