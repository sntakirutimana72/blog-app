class ApiController < ActionController::API
  include AuthenticationJwt

  before_action :authenticate_user!

  private

  def authenticate_user!
    token = request.headers[:Authorization]
    token = token.split.last if token
    payload = jwt_decrypt(token)
    @signed_user = User.find(payload[:user_id])
  rescue StandardError
    render(json: 'Invalid Credentials', status: :unauthorized)
  end
end
