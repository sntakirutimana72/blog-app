class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    respond_to do |res|
      res.html do
        comment.save
        redirect_to user_posts_path(current_user)
      end
    end
  end

  def comment_params
    params
      .require(:comment)
      .permit(:text)
      .merge(author: current_user, post_id: params.require(:post_id))
  end
end
