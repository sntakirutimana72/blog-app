require 'rails_helper'

RSpec.describe 'Show Page', type: :feature do
  before(:each) do
    visit(user_path(@user))
  end

  before(:all) do
    @user = User.create(
      name: 'Tom', posts_counter: 0,
      bio: "I'm a full-stack software developer",
      photo: 'https://image.test/img.png'
    )
  end

  after(:all) do
    Post.delete_all
    User.delete_all
  end

  describe 'Author Preview' do
    it 'should contain user link' do
      expect(page).to have_css('a.author-of-post', count: 1)
    end

    it 'should contain author name' do
      expect(page).to have_xpath('//span', text: @user.name)
    end

    it 'should display number of posts written by self' do
      expect(page).to have_text("Number of posts: #{@user.posts_counter}")
    end

    it "should display author's bio" do
      expect(page).to have_text(@user.bio)
    end
  end

  describe 'Main' do
    it 'should contain link to all-posts page' do
      expect(page).to have_css("a[href='#{user_posts_path(@user)}']")
    end

    it 'should redirect to user post index page' do
      click_link 'SEE ALL POSTS'
      expect(current_path).to eq(user_posts_path(@user))
    end
  end

  describe 'New Post Preview' do
    it 'should contain link to new post page' do
      expect(page).to have_css("[href='#{new_user_post_path(@user)}']")
    end

    it 'should redirect to new post page' do
      redirect_path = new_user_post_path(@user)
      page.find("[href='#{redirect_path}']").click
      expect(current_path).to eq(redirect_path)
    end
  end

  describe 'Post Links' do
    before(:all) do
      (1..6).each do |j|
        Post.create(
          author: @user,
          title: "TEST_POST_#{j}", text: "TEST_TEXT_#{j}",
          likes_counter: 0, comments_counter: 0
        )
        sleep(0.025)
      end
    end

    it 'should contain at most 3 links to `show user post` page' do
      expect(page).to have_css('a.post-anchor', count: @user.recent_three_posts.length)
    end

    it 'should redirect to show user post page when clicked' do
      redirect_path = user_post_path(@user, @user.recent_three_posts.first)
      page.find("[href='#{redirect_path}']").click
      expect(current_path).to eq(redirect_path)
    end
  end
end
