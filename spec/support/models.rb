# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
  end

  create_table :posts, force: true do |t|
    t.integer :user_id
    t.string :content
    t.datetime :created_at
  end

  create_table :comments, force: true do |t|
    t.integer :post_id
    t.string :content
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class User < ApplicationRecord; end

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
end

class Comment < ApplicationRecord; end
