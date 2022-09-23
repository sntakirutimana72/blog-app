class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @author = @posts ? @posts.first.author : {}
  end

  def show
    @post = Post.where(author_id: params[:user_id], id: params[:id]).first
  end

  def new
    post = Post.new
    respond_to do |res|
      res.html { render :new, locals: { post:, author: current_user } }
    end
  end

  def create
    post = Post.new(post_params)
    respond_to do |res|
      res.html do
        if post.save
          flash[:success] = 'Post saved successfully!'
          redirect_to user_path(current_user)
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new, status: :unprocessable_entity, locals: { post:, author: current_user }
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
