class CashierPagesController < ApplicationController
  before_action :filter_role
  layout "cashier_layout"

  def sale_list
    @sales = Ckfapi::API::Sale.index(current_token,detail: true)['sales'] rescue []
    @sales = @sales.sort{|a, b| b['updated_at'].to_datetime <=> a['updated_at'].to_datetime}
    @sales_not_saved = @sales.select{|m| m['state'] != 'saved'}
    @sales_init     = @sales.select{|m| m['state'] == 'init'}.count
    @sales_delivered     = @sales.select{|m| m['state'] == 'delivered'}.count
    respond_to do |format|
      format.html
    end
  end

  def save_sale
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(current_token,params[:sale_id],"saved")
      @sale['sale']['format_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%d/%m/%Y")
      @sale['sale']['order_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
      @sale['sale']['format_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("%d/%m/%Y <b>%H:%M</b>").html_safe
      @sale['sale']['order_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
      WebsocketRails[:staff].trigger 'next_state_sale_menu_item',@sale
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id].blank?
      @sale_menu_item =  update_next_state_sale_menu_item(current_token,params[:sale_menu_id],"saved")
      WebsocketRails[:staff].trigger 'next_state_sale_menu_item',@sale_menu_item
      respond_to do |format|
        format.js
      end
    end
    #TODO
  end

  def sale_details
    @sale = Ckfapi::API::Sale.get(current_token, params[:id], detail: true)
    respond_to do |format|
      format.js
    end
  end

  def saved_sales
    @sales = Ckfapi::API::Sale.index(current_token,detail: true)['sales'] rescue []
    @saved_sales = @sales.select{|m| m['state'] == 'saved'}
  end

  private

  def filter_role
    return true if ["Manager", "Cashier"].include? current_user['role']
    redirect_to get_root_path(current_user)
  end

end
