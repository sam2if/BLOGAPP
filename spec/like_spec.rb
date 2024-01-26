require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      association = Like.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a post' do
      association = Like.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  describe 'update_likes_counter method' do
    it 'increments the like counter of the associated post' do
      post = nil

      ActiveRecord::Base.transaction do
        user = User.create(name: 'John Doe')
        post = Post.new(title: 'Sample Post', comment_counter: 0, like_counter: 0, author: user)
        like = Like.new(user:, post:)

        post.save!
        like.save!
      end

      expect(post.reload.like_counter).to eq(1)
    end
  end
end
