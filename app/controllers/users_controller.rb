class UsersController < ApplicationController
  # before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    p params
    @user = User.find_by(id: params[:id])
  end
end
