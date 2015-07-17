class RegistrationsController < ApplicationController

  before_action :is_manager?

  def new
  end

  def edit
    @user = Ckfapi::API::User.get(current_token, params[:id])['user']
  end

  def update
    @user = Ckfapi::API::User.update(current_token, params[:id], params[:user])['user']
    render 'edit'
  end

  def create
    @user = Ckfapi::API::User.create(current_token, params[:user])
    if @user['user']
      redirect_to edit_registration_path(@user['user']['id'])
    else
      render 'new'
    end
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
