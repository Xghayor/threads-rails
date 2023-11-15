require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get users_url
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_url
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create!(name: 'Ahmad', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Some bio',
                          posts_counter: 1)

      get users_path
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create!(name: 'John', photo: 'example.jpg', bio: 'Some bio', posts_counter: 0)
      get user_url(user)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create!(name: 'John', photo: 'example.jpg', bio: 'Some bio', posts_counter: 0)
      get user_url(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create!(name: 'John', photo: 'example.jpg', bio: 'Some bio', posts_counter: 0)

      get user_path(user)
      expect(response.body).to include(user.name)
    end
  end
end
