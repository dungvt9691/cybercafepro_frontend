class RegistrationsController < ApplicationController

  before_action :is_manager?

  def new
  end

  def edit
    @user = Ckfapi::API::User.get(current_token, params[:id])['user']
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    if params[:user]
      @user = Ckfapi::API::User.update(current_token, params[:id], params[:user])
    else
      @user = nil
    end
    respond_to do |format|
      format.html {
        redirect_to edit_registration_path(params[:id])
      }
      format.js
    end
  end

  def create
    @user = Ckfapi::API::User.create(current_token, params[:user])
    if @user['user']
      redirect_to edit_registration_path(@user['user']['id'])
    else
      render 'new'
    end
  end

  def destroy
    @user_id = params[:id]
    @user = Ckfapi::API::User.remove(current_token, params[:id])
    respond_to do |format|
      format.js
    end
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
