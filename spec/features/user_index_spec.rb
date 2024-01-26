require 'rails_helper'

RSpec.describe "Visit the index page of 'users'", type: :feature do
  before :each do
    @first_user = User.create(name: 'Frank Miller', photo: 'https://randomuser.me/api/portraits/men/88.jpg',
                              bio: 'Hello! I am a Ruby Backend Developer from USA.')
    @second_user = User.create(name: 'Jason Rogers', photo: 'https://randomuser.me/api/portraits/men/90.jpg',
                               bio: 'Hello! I am a Web designer from UK.')
  end

  it 'should display the username of all the users' do
    visit users_path
    expect(page).to have_content 'Frank Miller'
    expect(page).to have_content 'Jason Rogers'
  end

  it 'should display the profile picture of each user' do
    visit users_path
    expect(page).to have_selector('img')
    expect(page).to have_css("img[src='https://randomuser.me/api/portraits/men/88.jpg']")
    expect(page).to have_css("img[src='https://randomuser.me/api/portraits/men/90.jpg']")
  end

  it 'should display the number of posts each user has written' do
    Post.create(author: @first_user, title: 'Post 1', text: 'This is the content of Post 1')
    Post.create(author: @first_user, title: 'Post 2', text: 'This is the content of Post 2')
    Post.create(author: @second_user, title: 'Post 1 second user',
                text: 'This is the content of Post 1 of second user')
    visit users_path
    expect(page).to have_content 'Number of post: 2'
    expect(page).to have_content 'Number of post: 1'
    expect(page).to have_content 'Number of post: 0'
  end

  it 'Clicking on each username should redirect to user\'s show page' do
    visit users_path
    click_link 'Frank Miller'
    expect(page).to have_current_path(user_path(@first_user))
  end
end
