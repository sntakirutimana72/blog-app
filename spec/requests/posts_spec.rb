require 'rails_helper'

RSpec.describe PostsController, type: :request do
  before(:all) do
    @user = User.create(name: 'Tom', photo: '', posts_counter: 0)
    @post = Post.create(
      author: @user,
      title: '1st Post!',
      text: '1st post',
      comments_counter: 0,
      likes_counter: 0
    )
    Comment.create(author: @user, post: @post, text: '1st comment')
    Comment.create(author: @user, post: @post, text: '2nd comment')
    Comment.create(author: @user, post: @post, text: '3rd comment')
  end

  describe ':index' do
    before { get user_posts_path(@user) }

    it('status should be :ok') do
      expect(response).to have_http_status(:ok)
    end

    it('should render correct templates') do
      expect(response).to render_template(:index)
      expect(response).to render_template('shared/_author')
      expect(response).to render_template('shared/_post')
      expect(response).to render_template('shared/_comment')
    end

    it('should assign Post.where(author_id = params[:user_id]) to @posts') do
      expect(assigns(:posts)).to eq(@user.posts)
    end
  end

  context ':show' do
    before { get user_post_path(@user, @post) }

    it('status should be :ok') do
      expect(response).to have_http_status(:ok)
    end

    it('should render correct templates') do
      expect(response).to render_template(:show)
      expect(response).to render_template('shared/_comment')
    end

    it('should assign Post.where(author_id: params[:user_id], id: params[:id]).first to @post') do
      expect(assigns(:post)).to eq(@post)
    end

    it('response content should contain `@post.text`') do
      expect(response.body).to match(%r{#{@post.text}})
    end
  end
end
