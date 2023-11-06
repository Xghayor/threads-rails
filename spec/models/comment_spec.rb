require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Mission Impossible', text: 'Fallout', likes_counter: 0) }

  describe 'validations' do
    it 'should validate presence of text' do
      comment = Comment.create(post:, user:, text: 'Hi Tom!')
      expect(comment).to be_valid
    end
    it 'should show an error if comments_counter is negative' do
      post.comments_counter = -2
      expect(post).not_to be_valid
    end

    it 'should be valid when comments_counter is zero' do
      post.comments_counter = 0
      expect(post).to be_valid
    end

    it 'should be valid when comments_counter is positive' do
      post.comments_counter = 2
      expect(post).to be_valid
    end
  end

  describe 'after_save' do
    it 'should update the post comments counter' do
      comment = Comment.create(post:, user:, text: 'Hi Tom!')
      expect { comment.save }.to change { post.comments_counter }.by(1)
    end
  end
end
