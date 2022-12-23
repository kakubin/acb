# frozen_string_literal: true

module ActiveRecord
  class Faker
    LOREM = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non aliquet diam. Curabitur vel urna metus, quis malesuada elit.
     Integer consequat tincidunt felis. Etiam non erat dolor. Vivamus imperdiet nibh sit amet diam eleifend id posuere diam malesuada. Mauris at accumsan sem.
     Donec id lorem neque. Fusce erat lorem, ornare eu congue vitae, malesuada quis neque. Maecenas vel urna a velit pretium fermentum. Donec tortor enim,
     tempor venenatis egestas a, tempor sed ipsum. Ut arcu justo, faucibus non imperdiet ac, interdum at diam. Pellentesque ipsum enim, venenatis ut iaculis vitae,
     varius vitae sem. Sed rutrum quam ac elit euismod bibendum. Donec ultricies ultricies magna, at lacinia libero mollis aliquam. Sed ac arcu in tortor elementum
     tincidunt vel interdum sem. Curabitur eget erat arcu. Praesent eget eros leo. Nam magna enim, sollicitudin vehicula scelerisque in, vulputate ut libero.
     Praesent varius tincidunt commodo".split

    def self.name
      LOREM.grep(/^\w*$/).sort_by { rand }.first(2).join ' '
    end

    def self.comment
      LOREM.grep(/^\w*$/).sort_by { rand }.first(2).join ' '
    end
  end
end

USER_SIZE = 10
POST_PER_USER = 20
COMMENT_PER_POST = 25

notes = ActiveRecord::Faker::LOREM.join ' '
now = Time.now

USER_SIZE.times do
  user = User.create(name: ActiveRecord::Faker.name)

  POST_PER_USER.times do
    post = Post.create(
      user: user,
      content: notes,
      created_at: now
    )

    COMMENT_PER_POST.times do
      post.comments.create(
        content: ActiveRecord::Faker.comment
      )
    end
  end
end
