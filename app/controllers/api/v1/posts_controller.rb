class Api::V1::PostsController < Api::ApiController
  skip_before_action :authenticate_user!, only: :index

  def index
    @posts = Post.where(author_id: params[:user_id])
    status = @posts.empty? ? :not_found : :ok
    render(json: @posts, status:)
  end
end
