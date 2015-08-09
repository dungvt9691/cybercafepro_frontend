class SaleMenuItemsController < ApplicationController

  before_action :filter_role, :only => [:destroy]

  def show
    @sale_menu_item = Ckfapi::API::SaleMenuItem.get(current_token, params[:id], { detail: true })
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @sale_menu_item_id = params[:id]
    sale_menu_item = Ckfapi::API::SaleMenuItem.get(current_token, params[:id], {detail: true})
    @sale_menu_item = Ckfapi::API::SaleMenuItem.remove(current_token, params[:id])
    WebsocketRails[:staff].trigger 'destroy_sale_menu_item', sale_menu_item if @sale_menu_item.blank?
    respond_to do |format|
      format.js
    end
  end

  private

  def filter_role
    return true if current_user && ["Manager","Customer"].include?(current_user['current_role'])
    flash[:error] = "Can only be acessed by Manager"
    redirect_to get_root_path(current_user)
  end

end
