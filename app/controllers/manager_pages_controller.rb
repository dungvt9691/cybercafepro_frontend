class ManagerPagesController < ApplicationController
  before_action :is_manager?
  layout "manager_layout"

  def user_list
    @mg_page = "staff"
    @users = Ckfapi::API::User.index(current_token)['users']
  end

  def menu_item_list
    @mg_page = "menu_item"
    @menu_items = Ckfapi::API::MenuItem.index(current_token)['menu_items']
  end

  def payment_list
    @mg_page = "payment"
    @menu_items = Ckfapi::API::Payment.index(current_token)['payments']
  end

  def sale_list
    @mg_page = "sale"
    @sales = Ckfapi::API::Sale.index(current_token, detail: true)['sales'] rescue []
    respond_to do |format|
      format.html
    end
  end

  private

  def is_manager?
    if current_user && current_user['role'] == "Manager"
      return true
    else
      flash[:error] = "Only Manager can register new user"
      redirect_to root_path
    end
  end

end
