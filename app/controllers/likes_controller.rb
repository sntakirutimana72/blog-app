class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    respond_to do |res|
      res.html do
        like.save
        redirect_to user_path(User.find(params.require(:user_id)))
      end
    end
  end

  def like_params
    {
      post_id: params.require(:post_id),
      author: current_user
    }
  end
end
