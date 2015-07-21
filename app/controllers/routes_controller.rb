class RoutesController < ApplicationController

  def root
    root_p = get_root_path(current_user)
    redirect_to root_p
  end

end
