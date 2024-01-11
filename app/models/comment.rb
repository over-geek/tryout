# Represents a comment associated with a post and a user.
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, foreign_key: 'author_id'
end
