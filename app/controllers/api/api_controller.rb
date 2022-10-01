class Api::ApiController < ActionController::API
  include AuthenticationJwt

  before_action :authenticate_user!

  private

  def authenticate_user!
    p request.headers[:Authorization]
    token = request.headers[:Authorization]
    token = token.split.last if token
    payload = jwt_decrypt(token)
    @signed_user = User.find(payload[:user_id])
  rescue StandardError
    render(json: '', status: :unauthorized)
  end
end
