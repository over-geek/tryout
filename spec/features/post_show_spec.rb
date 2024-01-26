require 'rails_helper'

RSpec.describe 'Visit the post show page', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe', photo: 'user_photo_url', bio: 'Sample bio')
    @post = Post.create(author: @user, title: 'Post Title', text: 'Post body text')
    @commenter1 = User.create(name: 'Commenter 1', photo: 'commenter1_photo_url', bio: 'Commenter 1 bio')
    @commenter2 = User.create(name: 'Commenter 2', photo: 'commenter2_photo_url', bio: 'Commenter 2 bio')

    Comment.create(post: @post, author: @commenter1, text: 'Comment 1')
    Comment.create(post: @post, author: @commenter2, text: 'Comment 2')
  end

  it 'displays post details' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Post Title'
    expect(page).to have_content 'John Doe'
    expect(page).to have_content 'Post body text'
    expect(page).to have_content 'Comments: 2'
    expect(page).to have_content 'Likes: 0'
  end

  it 'displays comments and commenters' do
    visit user_post_path(@user, @post)

    expect(page).to have_content 'Commenter 1'
    expect(page).to have_content 'Comment 1'
    expect(page).to have_content 'Commenter 2'
    expect(page).to have_content 'Comment 2'
  end
end
