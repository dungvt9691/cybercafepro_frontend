class CustomerPagesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:customer_ordering,:create_sale]
  layout "customer_layout"

  append_view_path(File.join(Rails.root,"app/views/customer_pages"))

  def customer_ordering
    @categories = Ckfapi::API::Category.index(current_token, {detail: true})
    @foods = @categories["categories"].find {|e| e["name"] == "Foods" }
    @food_types = @foods['menu_items'].map {|e| e['mtype']}.uniq

    @drinks = @categories["categories"].find {|e| e["name"] == "Bevarages" }
    @drink_types = @drinks['menu_items'].map {|e| e['mtype']}.uniq

    @services = @categories["categories"].find {|e| e["name"] == "Game Service" }
    @service_types = @services['menu_items'].map {|e| e['mtype']}.uniq
  end

  def create_sale
    #TODO
    ip = request.remote_ip
    params['sale']['customer_id'] = extract_customer_id_from_ip ip
    unless params['sale']['customer_id'].nil?
      params["sale"]["sale_menu_items_attributes"] = params["sale"]["sale_menu_items_attributes"].values
      @sale = Ckfapi::API::Sale.create(current_token, params["sale"])
      @sale['sale']['format_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%d/%m/%Y")
      @sale['sale']['order_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
      @sale['sale']['format_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("%d/%m/%Y <b>%H:%M</b>").html_safe
      @sale['sale']['order_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
      WebsocketRails[:staff].trigger 'create_sale',@sale
    end
    respond_to do |format|
      format.js
      format.json { render :json => { sale: @sale} }
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
