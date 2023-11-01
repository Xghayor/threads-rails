class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  after_create :update_post_comments_counter

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
