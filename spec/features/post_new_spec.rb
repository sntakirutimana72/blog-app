require 'rails_helper'

RSpec.describe 'Add Post Form', type: :feature do
  let(:user) { User.create(name: 'USER_1', posts_counter: 0, photo: 'https://image.dom.png') }
  let(:redirected_to) { user_path(User.first) }
  let(:submit) { page.find("input[type='submit']") }

  before(:each) { visit(new_user_post_path(user)) }

  after(:all) do
    Like.delete_all
    Comment.delete_all
    Post.delete_all
    User.delete_all
  end

  describe 'Form Elements' do
    it 'should contain title & text fields' do
      expect(page).to have_css("input[type='text']", count: 1)
      expect(page).to have_css('textarea', count: 1)
    end
    
    it 'should contain a submit button' do
      expect(page).to have_css("input[type='submit']", count: 1)
    end
  end
  
  describe 'Form Submission' do
    it 'should not submit without title' do
      fill_in(:post_text, with: 'TEST_NEW_POST_TEXT')
      submit.click
      expect(current_path).to_not eq(redirected_to)
    end
    
    it 'should submit successfully' do
      old_counter = User.first.posts_counter
      fill_in(:post_title, with: 'TEST_NEW_POST_TITLE')
      fill_in(:post_text, with: 'TEST_NEW_POST_TEXT')
      submit.click
      expect(current_path).to eq(redirected_to)
      expect(User.first.posts_counter).to eq(old_counter + 1)
    end
  end
end
