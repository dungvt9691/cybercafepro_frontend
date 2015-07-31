class UsersController < ApplicationController

  before_action :is_manager?

  def show
    @user = Ckfapi::API::User.get(current_token, params[:id])['user']
    respond_to do |format|
      format.js
    end
  end

  def index
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
