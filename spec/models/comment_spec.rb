# spec/models/comment_spec.rb

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'update_post_comments_counter' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }
    let!(:comment) { create(:comment, user:, post:) }

    it 'updates the comments_counter of the associated post' do
      initial_comments_count = post.comments.count

      # Call the method to update the comments_counter
      comment.update_post_comments_counter

      # Reload the post from the database to get the updated comments_counter
      post.reload

      expect(post.comments_counter).to eq(initial_comments_count + 1)
    end
  end
end
