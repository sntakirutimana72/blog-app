require 'rails_helper'

describe Post, type: :model do
  before(:each) do
    @user = User.create(name: 'Tom', posts_counter: 0)
    @post = described_class.create(
      author: @user,
      title: 'Greetings!',
      text: 'This is my first post.',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  context 'custom methods' do
    it 'calling :increment_posts_counter should increment User:posts_counter by 1' do
      expect(@user.posts_counter).to eq(1)
      @post.increment_posts_counter
      expect(@user.posts_counter).to eq(2)
    end

    it ':recent_five_comments should return at most 5 recent comments' do
      comments = []
      (1..12).each do |j|
        comments << Comment.create(
          author: @user,
          post: @post,
          text: "This is my #{j} time(s) comment."
        )
        sleep(0.125)
      end
      comments[4].created_at = DateTime.now + 2.hour
      comments[4].save
      recent_five = @post.recent_five_comments
      expect(recent_five.count).to eq(5)
      expect(recent_five.first).to eq(comments[4])
    end
  end

  context 'Associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should belong_to(:author) }
  end

  context 'with valid attributes' do
    it 'is valid' do
      expect(@post).to be_valid
    end

    it 'is valid without :text' do
      @post.text = nil
      expect(@post).to be_valid
    end

    it 'is valid when :title length is between 1 and 250' do
      @post.title = 'H'
      expect(@post).to be_valid
      @post.title = 'k' * 250
      expect(@post).to be_valid
    end
  end

  describe 'with invalid attributes' do
    context 'on :title' do
      it 'is invalid without :title' do
        @post.title = nil
        expect(@post).to_not be_valid
      end

      it 'is invalid when :title length > 250' do
        @post.title = 's' * 251
        expect(@post).to_not be_valid
      end

      it 'is invalid when :title is empty' do
        @post.title = ''
        expect(@post).to_not be_valid
      end
    end

    context 'on :comments_counter' do
      it 'is invalid without :comments_counter' do
        @post.comments_counter = nil
        expect(@post).to_not be_valid
      end

      it 'is invalid when :comments_counter is a negative number' do
        @post.comments_counter = -2
        expect(@post).to_not be_valid
      end

      it 'is invalid when :comments_counter is not a whole number' do
        @post.comments_counter = 3.25
        expect(@post).to_not be_valid
      end
    end

    context 'on :likes_counter' do
      it 'is invalid without :likes_counter' do
        @post.likes_counter = nil
        expect(@post).to_not be_valid
      end

      it 'is invalid when :likes_counter is a negative number' do
        @post.likes_counter = -2
        expect(@post).to_not be_valid
      end

      it 'is invalid when :likes_counter is not a whole number' do
        @post.likes_counter = 2.75
        expect(@post).to_not be_valid
      end
    end
  end
end
