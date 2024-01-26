require 'rails_helper'

RSpec.describe Post do
  describe 'validations' do
    it 'requires a title' do
      post = Post.new(title: nil)
      expect(post).not_to be_valid
    end

    it 'has a maximum length for the title' do
      post = Post.new(title: 'a' * 251)
      expect(post).not_to be_valid
    end

    it 'requires a comment counter to be an integer' do
      post = Post.new(comment_counter: '5')
      expect(post).not_to be_valid
    end

    it 'requires comment counter to be greater than or equal to 0' do
      post = Post.new(comment_counter: -1)
      expect(post).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      association = Post.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many likes' do
      association = Post.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many comments' do
      association = Post.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'recent_comments method' do
    it 'returns the 5 most recent comments' do
      comments = []
      post = nil

      ActiveRecord::Base.transaction do
        user = User.create(name: 'John Doe')
        post = Post.new(title: 'Sample Post', comment_counter: 0, like_counter: 0, author: user)

        comments << Comment.new(user:, post:, text: 'Comment 1')
        comments << Comment.new(user:, post:, text: 'Comment 2')
        comments << Comment.new(user:, post:, text: 'Comment 3')
        comments << Comment.new(user:, post:, text: 'Comment 4')
        comments << Comment.new(user:, post:, text: 'Comment 5')
        comments << Comment.new(user:, post:, text: 'Comment 6')

        post.save!
        comments.each(&:save!)
      end

      expect(post.recent_comments(5)).to match_array(comments[-5..])
    end
  end
end
