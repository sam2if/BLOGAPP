# spec/models/like_spec.rb

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'update_post_likes_counter' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }
    let!(:like) { create(:like, user:, post:) }

    it 'updates the likes_counter of the associated post' do
      initial_likes_count = post.likes.count

      # Call the method to update the likes_counter
      like.update_post_likes_counter

      # Reload the post from the database to get the updated likes_counter
      post.reload

      expect(post.likes_counter).to eq(initial_likes_count + 1)
    end
  end
end
