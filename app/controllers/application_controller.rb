class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper

  before_filter :maintain_mode
  before_filter :authenticate_user!

  protected

  def authenticate_user!
    if current_token && auth?(current_token)
      return true
    else
      redirect_to new_sessions_path
    end
  end

  def maintain_mode
    _open_maintance = false
    _temp_close_file = "/tmp/.closecyber"

    _open_maintance = true if File.exist?(_temp_close_file)

    if _open_maintance
      render text: "Hệ thống đang nâng cấp, xin vui lòng quay lại sau"
      return
    end
  end

end
