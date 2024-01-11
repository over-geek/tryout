# Represents a comment associated with a post and a user.
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, foreign_key: 'author_id'

  after_save :update_comments_counter

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
