module SessionsHelper
  extend self

  def get_token(email, password)
    session[:token] = Ckfapi::API::User.get_token(email, password)
  end

  def current_token
    session[:token]
  end

end
