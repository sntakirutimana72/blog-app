require 'jwt'

module AuthenticationJwt
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.secret_key_base

  def generate_auth_token
    jwt_encrypt(user_id: @user.id, exp: 6.hours.from_now)
  end

  def jwt_encrypt(exp: 7.days.from_now, **kwargs)
    kwargs[:exp] = exp.to_i
    JWT.encode(kwargs, SECRET_KEY)
  end

  def jwt_decrypt(token)
    decoded, = JWT.decode(token, SECRET_KEY)
    HashWithIndifferentAccess.new(decoded)
  end
end
