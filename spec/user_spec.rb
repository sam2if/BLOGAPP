require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires a name' do
      user = User.new(name: nil)
      expect(user).not_to be_valid
    end

    it 'requires the name to be unique' do
      User.create(name: 'John')
      user = User.new(name: 'John')
      expect(user).not_to be_valid
    end

    it 'requires a post counter' do
      user = User.new(post_counter: nil)
      expect(user).not_to be_valid
    end

    it 'requires the post counter to be an integer' do
      user = User.new(post_counter: '5')
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
    end
  end

  describe 'recent_posts method' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'John', post_counter: 0)

      posts = [
        user.posts.create(title: 'Post 1'),
        user.posts.create(title: 'Post 2'),
        user.posts.create(title: 'Post 3'),
        user.posts.create(title: 'Post 4'),
        user.posts.create(title: 'Post 5')
      ]

      expect(user.recent_posts).to match_array(posts.last(3))
    end
  end
end
