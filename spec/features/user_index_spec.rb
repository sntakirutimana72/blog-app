require 'rails_helper'

RSpec.describe 'Index Page', type: :feature do
  let(:users) { User.all }

  before(:all) do
    (1..10).each do |j|
      User.create(
        name: "USER_#{j}",
        photo: "https://td-domain.test/PHOTO_#{j}.jpg",
        posts_counter: 0
      )
    end

    @ids = User.ids

    (1..10).each do |k|
      Post.create(
        author_id: @ids.sample,
        title: "POST_TITLE_#{k}",
        text: "POST_TEXT_#{k}",
        comments_counter: 0, likes_counter: 0
      )
    end
  end

  after(:all) do
    Post.destroy_all
    User.destroy_all
  end

  before { visit(root_path) }

  it 'current path should be the same as root path' do
    expect(current_path).to eq(root_path)
  end

  it 'should contains links' do
    expect(page).to have_css('a.author-of-post', count: @ids.length)
  end

  it 'should contain user names' do
    users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'should contain spans with `Number of posts:`' do
    users.each do |user|
      expect(page).to have_xpath("//span[text()='Number of posts: #{user.posts_counter}']")
    end
  end

  it 'should contain image tags for all users' do
    expect(page).to have_css('img[alt="author"]', count: @ids.length)
  end

  it 'should redirect to user show page' do
    redirect_path = user_path(users.first)
    page.find("[href='#{redirect_path}']").click
    expect(current_path).to eq(redirect_path)
  end
end
