module SessionsHelper
  extend self

  def get_token(email, password)
    session[:token] = Ckfapi::API::User.get_token(email, password)
  end

  def remove_token(token)
    dtoken = Ckfapi::API::User.remove_token(token)
    session[:token] = nil if dtoken["message"].include? "Session deleted"
    session[:token]
  end

  def current_token
    session[:token]
  end

  def current_user
    session[:user] ||= Ckfapi::API::User.index(
      current_token,
      {email: current_token["user"]["email"] }
    )["users"][0] rescue nil
  end

end
