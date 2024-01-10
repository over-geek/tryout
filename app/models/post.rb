# frozen_string_literal: true

# Represents a post belonging to an author.
class Post < ApplicationRecord
  belongs_to :author
end
