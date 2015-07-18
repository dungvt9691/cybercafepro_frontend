module SessionsHelper
  include ApplicationHelper
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
    # if mobile_device?
      # Ckfapi::API::User.get_token("dungvt9691@gmail.com", 123123123)
    # else
      # Ckfapi::API::User.get_token("doankien.bui@gmail.com", 123123123)
    # end
  end

  def current_user
    current_token["token"]["user"] ||= Ckfapi::API::User.index(
      current_token,
      {email: current_token["user"]["email"] }
      )["users"][0] rescue nil
  end

  def get_root_path user
    case user['role']
    when "Waiter"
      sale_list_waiter_pages_path
    when "Cashier"
      sale_list_cashier_pages_path
    when "Chef"
      cooking_list_chief_pages_path
    when "Manager"
      user_list_manager_pages_path
    else
      customer_ordering_customer_pages_path
    end
  end

end
