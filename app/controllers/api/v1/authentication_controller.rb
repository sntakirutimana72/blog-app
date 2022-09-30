class Api::V1::AuthenticationController < Api::ApiController
  skip_before_action :authenticate_user!, only: :create

  def create
    @user = User.find_by_email(params[:email])
    if @user.valid_password?(params[:password])
      render(json: { token: generate_auth_token }, status: :ok)
    else
      render(json: 'unauthorized', status: :unauthorized)
    end
  end
end
