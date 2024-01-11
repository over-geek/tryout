# Represents a like associated with a post and a user.
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
