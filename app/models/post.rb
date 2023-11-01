class Post < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: :author_id
    has_many :comments
    has_many :likes

    def update_user_posts_counter
      self.author.update(postsCounter: self.author.posts.count)
    end

    def five_most_recent_comments
      self.comments.order(created_at: :desc).limit(5)
    end
  end