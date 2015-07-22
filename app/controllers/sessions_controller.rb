class SessionsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def new
  end

  def create
    @token = get_token(params[:email], params[:password])
    if @token && @token["token"]
      redirect_to get_root_path(current_user)
    else
      redirect_to new_sessions_path
    end
  end

  def destroy
    @dtoken = remove_token(current_token)
    if !@dtoken
      redirect_to new_sessions_path
    else
      redirect_to root_path
    end
  end

end
