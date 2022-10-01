class Api::V1::CommentsController < Api::ApiController
  skip_before_action :authenticate_user!, only: :index

  def index
    @comments = Comment.where(**index_params)

    if @comments.empty?
      render(json: '', status: :not_found)
    else
      render(json: @comments, status: :ok)
    end
  end

  def create
    @comment = Comment.new(create_params)

    if @comment.save
      render json: 'Created successfully!', status: :created
    else
      render json: { error: @comment.errors }, status: :unprocessable_entity
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
