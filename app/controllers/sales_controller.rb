class SalesController < ApplicationController

  before_action :filter_role, :only => [:destroy]

  def show
    @sale = Ckfapi::API::Sale.get(current_token, params[:id], { detail: true })
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @sale_id = params[:id]
    @sale = Ckfapi::API::Sale.remove(current_token, params[:id])
    respond_to do |format|
      format.js
    end
  end

  private

  def filter_role
    return true if current_user && ["Manager"].include?(current_user['current_role'])
    flash[:error] = "Can only be acessed by Manager"
    redirect_to get_root_path(current_user)
  end

end
