class CustomerPagesController < ApplicationController
  layout "customer_layout"

  append_view_path(File.join(Rails.root,"app/views/customer_pages"))

  def customer_ordering
    @categories = Ckfapi::API::Category.index({detail: true})
    @foods = @categories["categories"].find {|e| e["name"] == "Foods" }
    @food_types = @foods['menu_items'].map {|e| e['mtype']}.uniq

    @drinks = @categories["categories"].find {|e| e["name"] == "Bevarages" }
    @drink_types = @drinks['menu_items'].map {|e| e['mtype']}.uniq

    @services = @categories["categories"].find {|e| e["name"] == "Game Service" }
    @service_types = @services['menu_items'].map {|e| e['mtype']}.uniq
  end

  def create_sale
    #TODO
    WebsocketRails[:events].trigger 'create_sale',"test"
    respond_to do |format|
      format.js
    end
  end

  def edit_sale
    #TODO
  end

  def delete_sale
    #TODO
  end

  def history_sale
    #TODO
  end

end
