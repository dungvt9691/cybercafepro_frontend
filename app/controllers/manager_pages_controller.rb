class ManagerPagesController < ApplicationController
  before_action :is_manager?
  before_action :is_maker?
  skip_before_action :is_manager?, only: [:menu_item_list]
  layout "manager_layout"

  def user_list
    @mg_page = "staff"
    @users = Ckfapi::API::User.index(current_token)['users'] rescue []
  end

  def menu_item_list
    @mg_page = "menu_item"
    @menu_items = Ckfapi::API::MenuItem.index(current_token, detail: true)['menu_items'] rescue []
    @items = Ckfapi::API::Item.index(current_token, detail: true)['items'] rescue []
    @categories = Ckfapi::API::Category.index(current_token)['categories'] rescue []
  end

  def payment_list
    @mg_page = "payment"
    @menu_items = Ckfapi::API::Payment.index(current_token)['payments'] rescue []
  end

  def sale_list
    @mg_page = "sale"
    @sale_menu_items = Ckfapi::API::SaleMenuItem.index(current_token, detail: true)['sale_menu_items'] rescue []
    respond_to do |format|
      format.html
    end
  end

  def shift_list
    @mg_page = "shift"
    @shifts = Ckfapi::API::Shift.index(current_token, detail: true)['shifts'] rescue []
  end

  def accounting
    @mg_page = "accounting"
    @shifts = Ckfapi::API::Shift.index(current_token)['shifts'] rescue []
  end

  def stat
    date = Time.parse(params[:date])
    @sales = Ckfapi::API::Shift.stat(current_token, params[:shift_id], "sale", {
      year: date.year,
      month: date.month,
      day: date.day
    })['stats'] if date
    @attendances = Ckfapi::API::Shift.stat(current_token, params[:shift_id], "attendance", {
      year: date.year,
      month: date.month,
      day: date.day
    })['stats'] if date
    respond_to do |format|
      format.js
    end
  end

  private

  def is_manager?
    return true if ["Manager"].include? current_user['current_role']
    redirect_to get_root_path(current_user)
  end

  def is_maker?
    return true if ["Chef", "Bartender"].include? current_user['current_role']
    redirect_to get_root_path(current_user)
  end

end
