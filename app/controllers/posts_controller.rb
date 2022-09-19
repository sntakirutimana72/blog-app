class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @author = @posts ? @posts.first.author : {}
  end

  def show
    @post = Post.where(author_id: params[:user_id], id: params[:id]).first
  end
end
