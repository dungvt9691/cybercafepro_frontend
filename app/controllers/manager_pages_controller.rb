class ManagerPagesController < ApplicationController
  before_action :filter_role
  layout "manager_layout"

  def user_list
    @mg_page = "staff"
    @users = Ckfapi::API::User.index(current_token)['users'] rescue []
  end

  def menu_item_list
    @mg_page = "menu_item"
    @menu_items = Ckfapi::API::MenuItem.index(current_token, detail: true)['menu_items'] rescue []
  end

  def payment_list
    @mg_page = "payment"
    @menu_items = Ckfapi::API::Payment.index(current_token)['payments'] rescue []
  end

  def sale_list
    @mg_page = "sale"
    @sales = Ckfapi::API::Sale.index(current_token, detail: true)['sales'] rescue []
    respond_to do |format|
      format.html
    end
  end

  def shift_list
    @mg_page = "shift"
    @shifts = Ckfapi::API::Shift.index(current_token, detail: true)['shifts'] rescue []
  end

  private

  def filter_role
    return true if ["Manager"].include? current_user['role']
    redirect_to get_root_path(current_user)
  end

end
