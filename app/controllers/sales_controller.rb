class SalesController < ApplicationController

  # before_action :filter_role

  def show
    @sale = Ckfapi::API::Sale.get(current_token, params[:id], { detail: true })
    respond_to do |format|
      format.js
    end
  end

  private

  # def filter_role
    # return true if current_user && ["Manager", "Chef", "Bartender"].include?(current_user['current_role'])
    # flash[:error] = "Can only be acessed by Manager"
    # redirect_to get_root_path(current_user)
  # end

end
