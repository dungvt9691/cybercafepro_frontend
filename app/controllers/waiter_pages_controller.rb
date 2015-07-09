class WaiterPagesController < ApplicationController
  layout "waiter_layout"

  def sale_list
    @sales = Ckfapi::API::Sale.index(current_token, detail: true)['sales'] rescue []
    @sales = @sales.sort{|a, b| a['updated_at'].to_datetime <=> b['updated_at'].to_datetime}
    @sales_pending = []
    @sales_ready = []
    @sales_delivered = []
    @sales.each do |sale|
      if ["init", "pending"].include?(sale['state'])
        @sales_pending << sale if sale['state'] == "pending" && current_user['id'] == sale['pender_id']
        @sales_pending << sale if sale['state'] == "init"
      elsif ['done', 'delivering'].include?(sale['state'])
        @sales_ready << sale if sale['state'] == "delivering" && current_user['id'] == sale['deliverer_id']
        @sales_ready << sale if sale['state'] == "done"
      else
        @sales_delivered << sale
      end
    end
    respond_to do |format|
      format.html
    end
  end

  def init_sale_list
    #TODOt
  end

  def done_sale_list
    #TODO
  end

  def go_for_payment
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(current_token,params[:sale_id],"pending")
      WebsocketRails[:staff].trigger 'next_state_sale',@sale
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id].blank?
      @sale_menu_item =  update_next_state_sale_menu_item(current_token,params[:sale_menu_id],"pending")
      WebsocketRails[:staff].trigger 'next_state_sale_menu_item',@sale_menu_item
      respond_to do |format|
        format.js
      end
    end
    #TODO
  end

  def verify_payment
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(current_token,params[:sale_id],"processing")
      
      WebsocketRails[:staff].trigger 'next_state_sale',@sale
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id].blank?
      @sale_menu_item =  update_next_state_sale_menu_item(current_token,params[:sale_menu_id],"processing")
      WebsocketRails[:staff].trigger 'next_state_sale_menu_item',@sale_menu_item
      respond_to do |format|
        format.js
      end
    end
    #TODO
  end

  def go_deliver
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(current_token,params[:sale_id],"delivering")
      WebsocketRails[:staff].trigger 'next_state_sale',@sale
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id].blank?
      @sale_menu_item =  update_next_state_sale_menu_item(current_token,params[:sale_menu_id],"delivering")
      WebsocketRails[:staff].trigger 'next_state_sale_menu_item',@sale_menu_item
      respond_to do |format|
        format.js
      end
    end
    #TODO
  end

  def done_deliver
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(current_token,params[:sale_id],"delivered")
      WebsocketRails[:staff].trigger 'next_state_sale',@sale
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id].blank?
      @sale_menu_item =  update_next_state_sale_menu_item(current_token,params[:sale_menu_id],"delivered")
      WebsocketRails[:staff].trigger 'next_state_sale_menu_item',@sale_menu_item
      respond_to do |format|
        format.js
      end
    end
    #TODO
  end

  def redo
    if !params[:sale_id].blank?
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id].blank?
      respond_to do |format|
        format.js
      end
    end
    #TODO
  end

end
