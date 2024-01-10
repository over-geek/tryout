# frozen_string_literal: true

# Creates the comments table with text, post_id, and author_id columns.
class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :post, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
