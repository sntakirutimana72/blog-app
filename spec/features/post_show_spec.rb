require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  before(:each) { visit(user_post_path(@user, @post)) }

  before(:all) do
    @user = User.create(
      name: 'Tom', posts_counter: 0,
      bio: "I'm a full-stack software developer",
      photo: 'https://image.test/img.png'
    )
    @post = Post.create(
      author: @user,
      title: 'TEST_POST_WITH_DASH', text: 'TEST_TEXT_WITH_DASH',
      likes_counter: 0, comments_counter: 0
    )
  end

  after(:all) do
    Like.delete_all
    Comment.delete_all
    Post.delete_all
    User.delete_all
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

  describe 'Main' do
    it 'should contain the post author name' do
      expect(page).to have_text("by #{@user.name}")
    end

    it 'should contain the post title' do
      expect(page).to have_text(@post.title)
    end

    it 'should contain the post description' do
      expect(page).to have_text(@post.text)
    end

    it 'should display no comments when none available' do
      expect(page).to have_text('There are no comments for this post.')
    end
  end

  describe 'Comments Preview' do
    let(:commentator) do
      User.create(
        name: 'COMMENTATOR', posts_counter: 0,
        bio: 'QA Engineer',
        photo: 'https://image.test/img.png'
      )
    end

    before(:each) do
      @comment = Comment.create(
        author: commentator,
        post: @post,
        text: 'TEST_COMMENT_BODY'
      )
      page.refresh
    end

    it 'should display the commentator name' do
      expect(page).to have_xpath('//b', text: commentator.name)
    end

    it 'should display the comment text' do
      expect(page).to have_text(": #{@comment.text}")
    end
  end

  context 'Counters Preview' do
    it 'should display number of comments' do
      (1..2).each do |j|
        Comment.create(post: @post, author: @user, text: "COMMENT_TEXT_#{j}")
      end
      page.refresh
      expect(page).to have_text("Comments: #{@post.comments_counter}")
    end

    it 'should display number of likes' do
      (1..2).each do
        Like.create(post: @post, author: @user)
      end
      page.refresh
      expect(page).to have_text("Likes: #{@post.likes_counter}")
    end
  end
end
