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
    @sales = Ckfapi::API::Sale.index(current_token, { detail: true })['sales'] rescue []
    respond_to do |format|
      format.html
    end
  end

  def sale_menu_item_list
    @mg_page = "sale"
    @sale_menu_items = Ckfapi::API::SaleMenuItem.index(current_token, detail: true)['sale_menu_items'] rescue []
    respond_to do |format|
      format.js
    end
  end

  def shift_list
    @mg_page = "shift"
    @shifts = Ckfapi::API::Shift.index(current_token, detail: true)['shifts'] rescue []
  end

  def report_list
    @mg_page = "report"
    @reports = Ckfapi::API::Report.index(current_token, detail: true)['reports'] rescue []
  end

  def accounting
    @mg_page = "accounting"
    @shifts = Ckfapi::API::Shift.index(current_token)['shifts'] rescue []
  end

  def stat_sale
    from = Time.parse(params[:datetime][:from])
    to = Time.parse(params[:datetime][:to])
    @sales = Ckfapi::API::Shift.stat(current_token, params[:shift_id], "sale", {
      from: from,
      to: to
    })['stats'] if (!from.blank? && !to.blank?)

    # get sales by menu item
    sales_by_menu_item = @sales['sales'].values.sum.map { |e|
      {
        'id' => e['menu_item_details']['id'],
        'name' => e['menu_item_details']['name'],
        'category' => e['menu_item_details']['category']['name'],
        'klass' => e['menu_item_details']['klass'],
        'mtype' => e['menu_item_details']['mtype'],
        'quantity' => e['quantity'].to_f,
        'total_price' => e['quantity'].to_f*e['menu_item_details']['unit_price'].to_f
      }
    } if @sales
    @sales_by_menu_item = []
    sales_by_menu_item.each do |s|
      if !(el = @sales_by_menu_item.select { |e| e['id'] == s['id'] }[0]).blank?
        el['quantity'] += s['quantity']
        el['total_price'] += s['total_price']
      else
        @sales_by_menu_item << s
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def stat_attendance
    from = Time.parse(params[:datetime][:from])
    to = Time.parse(params[:datetime][:to])
    @attendances = Ckfapi::API::Shift.stat(current_token, params[:shift_id], "attendance", {
      from: from,
      to: to
    })['stats'] if (!from.blank? && !to.blank?)
    respond_to do |format|
      format.js
    end

  end

  private

  def filter_role
    case action_name
    when 'menu_item_list'
      return true if ["Manager", "Chef", "Bartender"].include?(current_user['current_role'])
    else
      return true if ["Manager"].include? current_user['current_role']
    end
    redirect_to get_root_path(current_user)
  end

end
