class ItemsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  before_action :filter_role

  def show
    @item = Ckfapi::API::Item.get(current_token, params[:id], { detail: true })
    respond_to do |format|
      format.js
    end
  end

  def new
  end

  def create
    @item = Ckfapi::API::Item.create(current_token, params[:item])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @item_id = params[:id]
    @user = Ckfapi::API::Item.remove(current_token, params[:id])
    respond_to do |format|
      format.js
    end
  end

  def edit
    @item = Ckfapi::API::Item.get(current_token, params[:id])['item']
    respond_to do |format|
      format.js
    end
  end

  def update
    if params[:item]
      @item = Ckfapi::API::Item.update(current_token, params[:id], params[:item])
    else
      @item = nil
    end
    respond_to do |format|
      format.js
      format.html {
        if @item
          flash[:success] = "Item name #{@item['name']} is updated" if @item
        end
        redirect_to edit_item_path(params[:id])
      }
    end
  end

  private

  def filter_role
    return true if current_user && ["Manager"].include?(current_user['current_role'])
    flash[:error] = "Can only be acessed by Manager"
    redirect_to get_root_path(current_user)
  end

end
