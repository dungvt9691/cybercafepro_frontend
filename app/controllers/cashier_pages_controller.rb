class CashierPagesController < ApplicationController
  before_action :filter_role
  layout "cashier_layout"

  def sale_list
  end

  def save_sale
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(current_token,params[:sale_id],"saved")
      @sale['sale']['format_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%d/%m/%Y")
      @sale['sale']['order_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
      @sale['sale']['format_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("<b>%H:%M</b> %d/%m/%Y").html_safe
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
    shifts = Ckfapi::API::Shift.index(current_token, detail: true)['shifts'] rescue []
    now = Time.now.getutc
    nowp = now.change({year: 1970, month: 1, day: 1})
    current_shift = shifts.select { |p| Time.parse(p['start_time']) < nowp && Time.parse(p['end_time']) > nowp }[0]
    diff = Time.parse(current_shift['start_time']).change({year: now.year, month: now.month, day: now.day}).to_i - Time.parse(current_shift['start_time']).to_i
    start_time = Time.parse(current_shift['start_time']) + diff
    end_time = Time.parse(current_shift['end_time']) + diff
    @sales = Ckfapi::API::Sale.index(current_token, {detail: true, filter: { from: (start_time - 43200), to: end_time } })['sales'] rescue []
    @saved_sales = @sales.select{|m| m['state'] == 'saved'}
  end

  def not_saved_sales
    shifts = Ckfapi::API::Shift.index(current_token, detail: true)['shifts'] rescue []
    now = Time.now.getutc
    nowp = now.change({year: 1970, month: 1, day: 1})
    current_shift = shifts.select { |p| Time.parse(p['start_time']) < nowp && Time.parse(p['end_time']) > nowp }[0]
    diff = Time.parse(current_shift['start_time']).change({year: now.year, month: now.month, day: now.day}).to_i - Time.parse(current_shift['start_time']).to_i
    start_time = Time.parse(current_shift['start_time']) + diff
    end_time = Time.parse(current_shift['end_time']) + diff
    @sales = Ckfapi::API::Sale.index(current_token, {detail: true, filter: { from: (start_time - 43200), to: end_time } })['sales'] rescue []
    @not_saved_sales = @sales.select{|m| m['state'] != 'saved'}
  end

  private

  def filter_role
    return true if ["Manager", "Cashier"].include? current_user['current_role']
    redirect_to get_root_path(current_user)
  end

end
