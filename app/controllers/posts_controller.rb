class PostsController < ApplicationController
  def index
    @posts = Post
      .includes(:author)
      .where(author_id: params[:user_id])
    author = User.find(params[:user_id])

    respond_to do |res|
      res.html { render(:index, locals: { author:, all: nil }) }
    end
  end

  def show
    @post = Post.where(author_id: params[:user_id], id: params[:id]).first

    respond_to do |res|
      res.html { render(:show, locals: { all: true }) }
    end
  end

  def new
    respond_to do |res|
      res.html { render(:new, locals: { post: Post.new, author: current_user }) }
    end
  end

  def create
    respond_to do |res|
      res.html do
        if Post.new(post_params).save
          flash[:success] = 'Post saved successfully!'
          redirect_to(user_path(current_user))
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render(
            :new,
            status: :unprocessable_entity,
            locals: {
              post: Post.new,
              author: current_user
            }
          )
        end
      end
    end
  end

  def post_params
    params
      .require(:post)
      .permit(:title, :text)
      .merge(author: current_user, comments_counter: 0, likes_counter: 0)
  end
end
