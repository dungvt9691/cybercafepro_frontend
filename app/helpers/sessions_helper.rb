module SessionsHelper
  extend self

  def get_token(email, password)
    session[:token] = Ckfapi::API::User.get_token(email, password)
  end

  def current_token
    session[:token]
  end

  def current_user
    session[:user] ||= Ckfapi::API::User.index(
      current_token,
      {email: current_token["user"]["email"] }
    )["users"]
  end

end
