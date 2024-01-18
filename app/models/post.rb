# Represents a post belonging to an author.
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counters, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize do |post|
    post.comments_counter ||= 0
    post.likes_counters ||= 0
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  after_save :update_posts_counter

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
