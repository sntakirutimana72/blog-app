require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe ':index' do
    before { get root_path }

    it('status should be :ok') do
      expect(response).to have_http_status(:ok)
    end

    it('should render correct templates') do
      expect(response).to render_template(:index)
      expect(response).to render_template('shared/_author')
    end

    it('should assign User.all to @users') do
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe ':show' do
    let!(:author) { User.create(name: 'James', posts_counter: 0, photo: '', bio: '') }

    before do
      Post.create(
        author:,
        title: 'TITLE',
        text: 'DESC',
        comments_counter: 0,
        likes_counter: 0
      )
      get user_path(author)
    end

    it('status should be :ok') do
      expect(response).to have_http_status(:ok)
    end

    it('should render corrent templates') do
      expect(response).to render_template(:show)
      expect(response).to render_template('shared/_post')
      expect(response).to render_template('shared/_author')
    end

    it('should assign User.find(params[:id]) to @user') do
      expect(assigns(:user)).to eq(author)
    end

    it('response content should contain `@author.name`') do
      expect(response.body).to match(
        %r{<span class="author-post-desc">#{author.name}</span>}
      )
    end
  end
end
