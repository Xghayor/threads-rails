class Post < ApplicationRecord
  before_create :set_default_values
  belongs_to :author, class_name: 'User', counter_cache: true
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_user_post_counter

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def set_default_values
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def update_user_post_counter
    author.increment!(:posts_counter)
  end
end
