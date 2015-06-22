class WaiterPagesController < ApplicationController

  def sale_list
    @sale = Ckfapi::API::Sale.index(detail: true)['sales'] rescue []
    respond_to do |format|
      format.html
    end
  end

  def init_sale_list
    #TODO
  end

  def done_sale_list
    #TODO
  end

  def go_for_payment
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(params[:sale_id],"pending")
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id.blank?]
      @sale_menu_item =  update_next_state_sale_menu_item(params[:sale_menu_id],"pending")
      respond_to do |format|
        format.js
      end
    end
    #TODO
  end

  def verify_payment
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(params[:sale_id],"processing")
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id.blank?]
      @sale_menu_item =  update_next_state_sale_menu_item(params[:sale_menu_id],"processing")
      respond_to do |format|
        format.js
      end
    end
    #TODO
  end

  def go_deliver
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(params[:sale_id],"delivering")
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id.blank?]
      @sale_menu_item =  update_next_state_sale_menu_item(params[:sale_menu_id],"delivering")
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
    elsif !params[:sale_menu_id.blank?]
      respond_to do |format|
        format.js
      end
    end
    #TODO
  end

end
