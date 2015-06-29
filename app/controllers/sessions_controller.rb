class SessionsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def new
  end

  def create
    @token = get_token(params[:email], params[:password])
    redirect_to root_path
  end

  def destroy
  end

end
