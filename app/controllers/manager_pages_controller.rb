class ManagerPagesController < ApplicationController

  layout "manager_layout"

  def index
    respond_to do |format|
      format.html
    end
  end


  def sale_list
    respond_to do |format|
      format.html
    end
  end

end
