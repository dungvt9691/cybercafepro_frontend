class CashierPagesController < ApplicationController

  def sale_list
    @sale = Ckfapi::API::Sale.index(current_token,detail: true)['sales'] rescue []
    respond_to do |format|
      format.html
    end
  end

  def save_sale
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(current_token,params[:sale_id],"saved")
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

  def history_sale
    #TODO
  end

end
