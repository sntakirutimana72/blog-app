class Api::V1::CommentsController < Api::ApiController
  skip_before_action :authenticate_user!, only: :index

  def index
    @comments = Comment.where(**index_params)
    status = @comments.empty? ? :not_found : :ok
    render(json: @comments, status:)
  end

  def create
    @comment = Comment.new(create_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.permit(:text, :post_id).merge(author: @signed_user)
  end

  def index_params
    {
      author_id: params[:user_id],
      post_id: params[:post_id]
    }
  end
end
