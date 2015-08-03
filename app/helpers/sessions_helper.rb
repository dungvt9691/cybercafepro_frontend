module SessionsHelper
  include ApplicationHelper
  extend self

  def get_token(email, password)
    token = Ckfapi::API::User.get_token(email, password)
    if token['token']
      session[:token] = token
    else
      session[:token] = nil
    end
  end

  def remove_token(token)
    # dtoken = Ckfapi::API::User.remove_token(token)
    session[:token] = nil
  end

  def auth?(token)
    auth = Ckfapi::API::User.auth(token)
    return true if auth['message'] == 'success'
    return false
  end

  def current_token
    if !(customer = CustomerDb.find_by_ip(request.remote_ip)).nil?
      get_token(customer.cs_email,123123123)
    else
      session[:token]
    end
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
    case user['current_role']
    when "Waiter"
      sale_list_waiter_pages_path
    when "Cashier"
      sale_list_cashier_pages_path
    when "Chef"
      cooking_list_chief_pages_path
    when "Bartender"
      cooking_list_bartender_pages_path
    when "Manager"
      accounting_manager_pages_path
    else
      customer_ordering_customer_pages_path
    end
  end

end
