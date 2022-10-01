class Api::V1::PostsController < Api::ApiController
  skip_before_action :authenticate_user!, only: :index

  def index
    @posts = Post.where(author_id: params[:user_id])

    if @posts.empty?
      render(json: '', status: :not_found)
    else
      render(json: @posts, status: :ok)
    end
  end
end
