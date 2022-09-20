require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe ':index' do
    before(:each) { get root_path }

    it('status should be :ok') do
      expect(response).to have_http_status(:ok)
    end

    it('rendered :index template') do
      expect(response).to render_template(:index)
    end

    it('should assign User.all to @users') do
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe ':show' do
    before(:each) do
      @author = User.create(name: 'James', posts_counter: 0, photo: '', bio: '')
      get user_path(@author)
    end

    it('status should be :ok') do
      expect(response).to have_http_status(:ok)
    end

    it('should render :show template') do
      expect(response).to render_template(:show)
    end

    it('should assign User.find(params[:id]) to @user') do
      expect(assigns(:user)).to eq(@author)
    end

    it('response content should contain `@author.name`') do
      expect(response.body).to match(%r{<h3>#{@author.name}</h3>})
    end
  end
end
