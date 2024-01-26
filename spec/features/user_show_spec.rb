require 'rails_helper'

RSpec.describe 'Visit the user show page', type: :feature do
  before :each do
    @user = User.create(
      name: 'John Doe',
      photo: 'https://randomuser.me/api/portraits/men/1.jpg',
      bio: 'A passionate individual with interesting stories to share.'
    )
    @post1 = Post.create(author: @user, title: 'Post 1', text: 'This is the content of Post 1')
    @post2 = Post.create(author: @user, title: 'Post 2', text: 'This is the content of Post 2')
    @post3 = Post.create(author: @user, title: 'Post 3', text: 'This is the content of Post 3')
  end

  it 'displays user information on the show page' do
    visit user_path(@user)

    expect(page).to have_selector('img[src=\'https://randomuser.me/api/portraits/men/1.jpg\']')
    expect(page).to have_content 'John Doe'
    expect(page).to have_content 'Number of posts: 3'
    expect(page).to have_content 'A passionate individual with interesting stories to share.'
  end

  it 'displays the first 3 posts of the user' do
    visit user_path(@user)

    expect(page).to have_content 'Post 1'
    expect(page).to have_content 'Post 2'
    expect(page).to have_content 'Post 3'
  end

  it 'redirects to the post show page when clicking a user\'s post' do
    visit user_path(@user)

    click_link 'Post 1'
    expect(page).to have_current_path(user_post_path(@user, @post1))
  end

  it 'redirects to the user\'s posts index page when clicking to see all posts' do
    visit user_path(@user)

    click_link 'See All Posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
