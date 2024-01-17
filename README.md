# Acb

Acb is a gem for formatting and outputting csv data from ActiveRecord data

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add acb


## Usage


```ruby
ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
  end

  create_table :posts, force: true do |t|
    t.integer :user_id
    t.timestamps
  end

  create_table :comments, force: true do |t|
    t.integer :post_id
    t.string :content
  end
end

class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :post
end

class PostCsvBuilder
  include Acb

  add_column name: 'id'
  add_column name: 'User Name', index: 'user.name'
  add_column name: 'created_at', format: '%Y-%m-%d'
  add_column name: 'Comment Amount', index: 'comments.size'
  add_column name: 'First Comment', index: ->(post) { post.comments.first&.content }
end

builder = PostCsvBuilder.new
relations = Post.where(user_id: user_id).preload(:user, :comments)
builder.load_from(relations)
builder.to_csv
```

### Advanced

You can also output with dynamically define columns at runtime.
Names too.

```ruby
class PostCsvAdvancedBuilder
  include Acb::Custom

  add_master_column key: 'id'
  add_master_column key: 'user_name', index: 'user.name'
end

builder1 = PostCsvAdvancedBuilder.use([
  { key: 'id', name: 'id' },
])

builder1.add_column(name: 'first comment', index: ->(post) { post.comments.first&.content })

builder1_instance = builder1.new
builder1_instance.load_from(relations)
builder1_instance.to_csv

builder2_instance = PostCsvAdvancedBuilder.use([
  { key: 'id', name: 'id' },
  { key: 'user_name', name: 'User Name' },
]).new

builder2_instance.load_from(relations)
builder2_instance.to_csv
```

## Code of Conduct

Everyone interacting in the Acb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kakubin/acb/blob/main/CODE_OF_CONDUCT.md).
