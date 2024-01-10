# frozen_string_literal: true

# Represents a like associated with a post and a user.
class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
end
