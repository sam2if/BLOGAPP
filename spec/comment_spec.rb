require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:example) do
    @user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
  end

  subject { Comment.new(user: @user, post: @post) }

  it 'user should be present' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'post should be present' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'calls update_comments_counter after save' do
    allow(subject).to receive(:update_comments_counter).and_call_original

    subject.save!

    expect(subject).to have_received(:update_comments_counter)
  end

  it 'increments comment_counter of associated post after save' do
    subject.save!

    @post.reload

    expect(@post.comment_counter).to eq(1)
  end
end
