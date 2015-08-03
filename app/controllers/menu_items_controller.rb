class MenuItemsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  before_action :filter_role

  def show
    @menu_item = Ckfapi::API::MenuItem.get(current_token, params[:id], { detail: true })
    respond_to do |format|
      format.js
    end
  end

  def new
  end

  def create
    @menu_item = Ckfapi::API::MenuItem.create(current_token, params[:menu_item])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @menu_item_id = params[:id]
    @user = Ckfapi::API::MenuItem.remove(current_token, params[:id])
    respond_to do |format|
      format.js
    end
  end

  def edit
    @menu_item = Ckfapi::API::MenuItem.get(current_token, params[:id])['menu_item']
    respond_to do |format|
      format.js
    end
  end

  def update
    if params[:menu_item]
      @menu_item = Ckfapi::API::MenuItem.update(current_token, params[:id], params[:menu_item])
    else
      @menu_item = nil
    end
    respond_to do |format|
      format.js
      format.html {
        if @menu_item
          flash[:success] = "MenuItem name #{@menu_item['name']} is updated" if @menu_item
        end
        redirect_to edit_menu_item_path(params[:id])
      }
    end
  end

  private

  def filter_role
    return true if current_user && ["Manager", "Chef", "Bartender"].include?(current_user['current_role'])
    flash[:error] = "Can only be acessed by Manager"
    redirect_to get_root_path(current_user)
  end

end
