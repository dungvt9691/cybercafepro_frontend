class ChiefPagesControllerController < ApplicationController

  def cooking_list
    #TODO
  end

  def start_cooking
    #TODO
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(params[:sale_id],"saved")
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id.blank?]
      @sale_menu_item =  update_next_state_sale_menu_item(params[:sale_menu_id],"saved")
      respond_to do |format|
        format.js
      end
    end
  end

  def done_cooking
    #TODO
    if !params[:sale_id].blank?
      @sale = update_next_state_sale(params[:sale_id],"saved")
      respond_to do |format|
        format.js
      end
    elsif !params[:sale_menu_id.blank?]
      @sale_menu_item =  update_next_state_sale_menu_item(params[:sale_menu_id],"saved")
      respond_to do |format|
        format.js
      end
    end
  end

  def redo_cooking
    #TODO
  end

end
