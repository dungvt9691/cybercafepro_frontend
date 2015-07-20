class ChiefPagesController < ApplicationController
  layout "chef_layout"

  def cooking_list
    #TODO
    @sales = Ckfapi::API::Sale.index(current_token, detail: true)['sales']
    @sales_processing = @sales.select{|m| m['state'] == 'processing' && !m['sale_menu_items_details'].empty?}
    @sales_cooking = @sales.select{|m| m['state'] == 'cooking' && !m['sale_menu_items_details'].empty?}
    respond_to do |format|
      format.html
    end
  end

  def start_cooking
    #TODO
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(current_token,params[:sale_id],"cooking")
      @sale['sale']['format_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%d/%m/%Y")
      @sale['sale']['order_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
      @sale['sale']['format_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("%d/%m/%Y <b>%H:%M</b>").html_safe
      @sale['sale']['order_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
      WebsocketRails[:staff].trigger 'next_state_sale',@sale
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id].blank?
      @sale_menu_item =  update_next_state_sale_menu_item(current_token,params[:sale_menu_id],"cooking")
      WebsocketRails[:staff].trigger 'next_state_sale_menu_item',@sale
      respond_to do |format|
        format.js
      end
    end
  end

  def done_cooking
    #TODO
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(current_token,params[:sale_id],"done")
      @sale['sale']['format_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%d/%m/%Y")
      @sale['sale']['order_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
      @sale['sale']['format_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("%d/%m/%Y <b>%H:%M</b>").html_safe
      @sale['sale']['order_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
      WebsocketRails[:staff].trigger 'next_state_sale',@sale
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id].blank?
      @sale_menu_item =  update_next_state_sale_menu_item(current_token,params[:sale_menu_id],"done")
      WebsocketRails[:staff].trigger 'next_state_sale_menu_item',@sale
      respond_to do |format|
        format.js
      end
    end
  end

  def redo_cooking
    #TODO
  end

end
