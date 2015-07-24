class MenuItemsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  before_action :is_manager?

  def new
  end

  def create
    @menu_item = Ckfapi::API::MenuItem.create(current_token, params[:menu_item])
    respond_to do |format|
      format.js
    end
  end

  def destroy
  end

  def edit
    @menu_item = Ckfapi::API::MenuItem.get(current_token, params[:id])['menu_item']
  end

  def update
    @menu_item = Ckfapi::API::MenuItem.update(current_token, params[:id], params[:menu_item])['menu_item']
    flash[:success] = "MenuItem name #{@menu_item['name']} is updated" if @menu_item
    redirect_to edit_menu_item_path(params[:id])
  end

  private

  def is_manager?
    if current_user && current_user['current_role'] == "Manager"
      return true
    else
      flash[:error] = "Only Manager can register new user"
      redirect_to root_path
    end
  end

end
