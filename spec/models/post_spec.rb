require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Mission Impossible', text: 'Fallout', likes_counter: 0) }

  describe 'validations' do
    it 'should validate presence of title' do
      post = Post.new(author: user, title: 'new title', text: 'New txt')

      expect(post).not_to be_valid
    end

    it 'should validate maximum length of title' do
      post = Post.new(title: 'a' * 251, author: User.new)

      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'should show error for manimum length of title' do
      post = Post.new(title: 'a' * 25, author: User.new)

      expect(post).not_to be_valid
    end

    it 'should validate numericality of comments_counter' do
      post = Post.new(comments_counter: -1, author: User.new)

      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'should validate numericality of likes_counter' do
      post = Post.new(likes_counter: -1, author: User.new)

      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'most_recent_comments' do
    it 'should return the most recent comments based on the limit number' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author: user, title: 'Mission Impossible', text: 'Fallout', likes_counter: 0,
                         comments_counter: 0)
      comment1 = Comment.create(user:, post:, text: 'Comment 1')
      comment2 = Comment.create(user:, post:, text: 'Comment 2')
      comment3 = Comment.create(user:, post:, text: 'Comment 3')
      comment4 = Comment.create(user:, post:, text: 'Comment 4')
      comment5 = Comment.create(user:, post:, text: 'Comment 5')

      expect(post.most_recent_comments(1)).to eq([comment5])
      expect(post.most_recent_comments(2)).to eq([comment5, comment4])
      expect(post.most_recent_comments(3)).to eq([comment5, comment4, comment3])
      expect(post.most_recent_comments(4)).to eq([comment5, comment4, comment3, comment2])
      expect(post.most_recent_comments(5)).to eq([comment5, comment4, comment3, comment2, comment1])
    end
  end

  describe 'after_save' do
    it 'should update the author posts counter' do
      post = Post.create(author: user, title: 'Mission Impossible', text: 'Fallout', likes_counter: 0,
                         comments_counter: 0)
      expect { post.save }.to change { user.posts_counter }.by(1)
    end
  end
end
