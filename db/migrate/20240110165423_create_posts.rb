# frozen_string_literal: true

# Creates the posts table with title, text, comments_counter, likes_counters, and author_id columns.
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counters
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
