class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper

  before_filter :authenticate_user!

  protected

  def authenticate_user!
    if !current_token["user"].nil?
      return true
    else
      redirect_to new_sessions_path
    end
  end
end
