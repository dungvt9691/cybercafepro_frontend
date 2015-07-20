class MenuItemsController < ApplicationController

  before_action :is_manager?

  def new
  end

  def create
  end

  def destroy
  end

  def edit
    @menu_item = Ckfapi::API::MenuItem.get(current_token, params[:id])['menu_item']
  end

  def update
    @menu_item = Ckfapi::API::MenuItem.update(current_token, params[:id], params[:menu_item])
    redirect_to edit_menu_item_path(params[:id])
  end

  private

  def is_manager?
    if current_user && current_user['role'] == "Manager"
      return true
    else
      flash[:error] = "Only Manager can register new user"
      redirect_to root_path
    end
  end

end
