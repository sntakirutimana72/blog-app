require 'rails_helper'

RSpec.describe 'Index Page', type: :feature do
  before(:each) { visit(user_posts_path(@user)) }

  before(:all) do
    @user = User.create(
      name: 'Tom', posts_counter: 0,
      bio: "I'm a full-stack software developer",
      photo: 'https://image.test/img.png'
    )
  end

  after(:all) do
    Like.delete_all
    Comment.delete_all
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
  end

  describe 'Posts Preview' do
    let(:post) { Post.first }

    before(:all) do
      (1..6).each do |j|
        Post.create(
          author: @user,
          title: "TEST_POST_#{j}", text: "TEST_TEXT_#{j}",
          likes_counter: 0, comments_counter: 0
        )
      end
    end

    it 'should contain a link with a post title' do
      expect(page).to have_xpath("//a[contains(text(), '#{post.title}')]")
    end

    it 'should contain a paragram with a post text' do
      expect(page).to have_xpath("//p[text()='#{post.text}']")
    end

    it 'should contain all posts links to `show user post` page' do
      expect(page).to have_css('a.post-anchor', count: @user.posts.count)
    end

    it 'should display number of comments' do
      (1..2).each do |j|
        Comment.create(post:, author: @user, text: "COMMENT_TEXT_#{j}")
      end

      page.refresh
      expect(page).to have_text("Comments: #{post.comments_counter}")
    end

    it 'should display number of likes' do
      (1..2).each do
        Like.create(post:, author: @user)
      end

      page.refresh
      expect(page).to have_text("Likes: #{post.likes_counter}")
    end

    it 'should be posts without comments' do
      expect(page).to have_text('There are no comments for this post.')
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

  describe 'Main' do
    it 'should contain a pagination button' do
      expect(page).to have_xpath('//button', text: 'Pagination')
    end
  end

  describe 'Comment Form Preview' do
    it 'should contain a form' do
      expect(page).to have_xpath("//form[div[@class='comment-form-field']]")
    end

    it 'should contain comment input field' do
      expect(page).to have_css('input.field')
    end

    it 'should contain a comment submit button' do
      expect(page).to have_css("input[value='Comment']")
    end
  end
end
