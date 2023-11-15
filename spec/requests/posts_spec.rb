require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    let(:user) do
      User.create!(name: 'John', photo: 'example.jpg', bio: 'Some bio', posts_counter: 0)
    end

    it 'renders a successful response' do
      get user_posts_path(user_id: user.id)
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get user_posts_path(user_id: user.id)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      post = user.posts.create!(title: 'Example Post', text: 'This is an example post', comments_counter: 0,
                                likes_counter: 0)

      get user_posts_path(user_id: user.id)
      expect(response.body).to include(post.title)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create!(name: 'John', photo: 'example.jpg', bio: 'Some bio', posts_counter: 0)
      post = user.posts.create!(title: 'Example Post', text: 'This is an example post', comments_counter: 0,
                                likes_counter: 0)

      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create!(name: 'John', photo: 'example.jpg', bio: 'Some bio', posts_counter: 0)
      post = user.posts.create!(title: 'Example Post', text: 'This is an example post', comments_counter: 0,
                                likes_counter: 0)

      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create!(name: 'John', photo: 'example.jpg', bio: 'Some bio', posts_counter: 0)
      post = user.posts.create!(title: 'Example Post', text: 'This is an example post', comments_counter: 0,
                                likes_counter: 0)

      get user_post_path(user_id: user.id, id: post.id)
      expect(response.body).to include(post.title)
    end
  end
end
