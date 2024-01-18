require 'rails_helper'

RSpec.describe 'PostsControllers', type: :request do
  let(:user) { User.create(name: 'John Doe') }
  let!(:post1) { Post.create(title: 'Post 1', text: 'Lorem ipsum', author: user) }
  let!(:post2) { Post.create(title: 'Post 2', text: 'Dolor sit amet', author: user) }

  describe 'GET index' do
    it 'returns a successful response and includes correct placeholder text' do
      get user_posts_path(user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('This is a lists of all Posts written by our Unique User John Doe😎')
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns http success status' do
      get user_post_path(user, post1)
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      get user_post_path(user, post1)
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      get user_post_path(user, post1)
      expect(response.body).to include('This is a lists of all Posts written by our Unique User John Doe😎')
    end
  end
end
