require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
             posts_counter: 0)
  end

  describe 'User attributes test, the user:' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if the posts_counter is not an integer' do
      subject.posts_counter = 1.5
      expect(subject).to_not be_valid
    end

    it 'is not valid if the posts_counter is below zero (negative number)' do
      subject.posts_counter = -2
      expect(subject).to_not be_valid
    end

    it 'is valid if the posts_counter is equal to zero' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end

    it 'is valid if the posts_counter is greather than zero (positive number)' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end
  end

  describe 'The most_recent_posts method' do
    it 'returns the most recent posts' do
      second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                bio: 'Teacher from Poland.')

      Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
      Post.create(author: second_user, title: 'Hello', text: 'This is my second post')
      Post.create(author: second_user, title: 'Hello', text: 'This is my third post')
      Post.create(author: second_user, title: 'Hello', text: 'This is my fourth post')
      Post.create(author: second_user, title: 'Hello', text: 'This is my fifth post')

      most_recent_posts = second_user.most_recent_posts
      expect(most_recent_posts).to eq(second_user.posts.order(created_at: :desc).limit(3))
    end
  end
end
