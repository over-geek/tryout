require 'rails_helper'

RSpec.describe 'Visit the user post index page', type: :feature do
  before :each do
    @user = User.create(
      name: 'John Doe',
      photo: 'https://randomuser.me/api/portraits/men/1.jpg',
      bio: 'A passionate individual with interesting stories to share.'
    )
    @post1 = Post.create(author: @user, title: 'Post 1', text: 'This is the content of Post 1')
    @post2 = Post.create(author: @user, title: 'Post 2', text: 'This is the content of Post 2')
    @comment1 = Comment.create(post: @post1, author: @user, text: 'First comment on Post 1')
    @comment2 = Comment.create(post: @post2, author: @user, text: 'First comment on Post 2')
    @comment3 = Comment.create(post: @post2, author: @user, text: 'Second comment on Post 2')
    @comment4 = Comment.create(post: @post2, author: @user, text: 'Third comment on Post 2')
    @comment5 = Comment.create(post: @post2, author: @user, text: 'Fourth comment on Post 2')
    @comment6 = Comment.create(post: @post2, author: @user, text: 'Fifth comment on Post 2')
    @comment7 = Comment.create(post: @post2, author: @user, text: 'Sixth comment on Post 2')
    @like1 = Like.create(post: @post1, user: @user)
  end

  it 'displays user information and posts on the index page' do
    visit user_posts_path(@user)

    expect(page).to have_selector('img[src=\'https://randomuser.me/api/portraits/men/1.jpg\']')
    expect(page).to have_content 'John Doe'
    expect(page).to have_content 'Number of posts: 2'
    expect(page).to have_content 'Post 1'
    expect(page).to have_content 'This is the content of Post 1'
    expect(page).to have_content 'Post 2'
    expect(page).to have_content 'This is the content of Post 2'
    expect(page).to have_content 'First comment on Post 1'
    expect(page).to have_content 'Second comment on Post 2'
    expect(page).to have_content 'Comments: 1'
    expect(page).to have_content 'Likes: 1'
  end

  it 'redirects to the post show page when clicking a post' do
    visit user_posts_path(@user)

    click_link 'Post 1'
    expect(page).to have_current_path(user_post_path(@user, @post1))
  end

  it 'displays pagination if there are more posts than fit on the view' do
    # Create additional posts to exceed the default per-page limit
    10.times { |i| Post.create(author: @user, title: "Post #{i + 3}", text: "This is the content of Post #{i + 3}") }

    visit user_posts_path(@user)

    expect(page).to have_content('Create new post')
  end

  it 'displays the first five comments on a post' do
    visit user_posts_path(@user)
    expect(page).to have_content 'Sixth comment on Post 2'
    expect(page).to have_content 'Fifth comment on Post 2'
    expect(page).to have_content 'Fourth comment on Post 2'
    expect(page).to have_content 'Third comment on Post 2'
    expect(page).to have_content 'Second comment on Post 2'
    expect(page).not_to have_content 'First comment on Post 2'
  end
end
