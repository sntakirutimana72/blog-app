require 'time'
require 'rails_helper'

describe User, type: :model do
  before(:each) do
    @user = described_class.create(
      name: 'Tom',
      photo: 'https://image.some-domain.url',
      bio: 'SOME_USER_BIO',
      posts_counter: 0
    )
  end

  context 'custom methods' do
    it ':recent_three_posts should return at most 3 recent posts' do
      posts = []
      (1..7).each do |j|
        posts << Post.create(
          author: @user,
          title: "[#{j}]: Hello!",
          text: "This is my #{j} time(s) post.",
          likes_counter: 0,
          comments_counter: 0
        )
        sleep(0.25)
      end
      posts[1].created_at = DateTime.now + 1.day
      posts[1].save
      recent_three = @user.recent_three_posts
      expect(recent_three.count).to eq(3)
      expect(recent_three.first).to eq(posts[1])
    end
  end

  context 'Associations' do
    it { should have_many(:posts) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
  end

  context 'with valid attributes' do
    it 'is valid' do
      expect(@user).to be_valid
    end

    it 'is valid without :photo' do
      @user.photo = nil
      expect(@user).to be_valid
    end

    it 'is valid without :bio' do
      @user.bio = nil
      expect(@user).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'is invalid without :name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'is invalid when :name length is less than 3' do
      @user.name = 'AJ'
      expect(@user).to_not be_valid
    end

    it 'is invalid without :posts_counter' do
      @user.posts_counter = nil
      expect(@user).to_not be_valid
    end

    it 'is invalid when :posts_counter is a negative number' do
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end

    it 'is invalid when :posts_counter is not a whole number' do
      @user.posts_counter = 2.5
      expect(@user).to_not be_valid
    end

    it 'is invalid when :posts_counter is less than 0' do
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end
  end
end
