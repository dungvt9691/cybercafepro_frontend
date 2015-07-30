class CustomerPagesController < ApplicationController
  # skip_before_filter :authenticate_user!, :only => [:customer_ordering,:create_sale]
  before_action :filter_role
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

    @sales = Ckfapi::API::Sale.index(current_token, detail: true)['sales'] rescue []
    @sales = @sales.sort{|a, b| b['created_at'].to_datetime <=> a['created_at'].to_datetime}
    @lated_sale = @sales.select{|s| s['customer_id'] == current_user['id']}.first
  end

  def create_sale
    #TODO
    ip = request.remote_ip
    # params['sale']['customer_id'] = extract_customer_id_from_ip ip
    params['sale']['customer_id'] = current_user['id']
    unless params['sale']['customer_id'].nil?
      params["sale"]["sale_menu_items_attributes"] = params["sale"]["sale_menu_items_attributes"].values
      @sale = Ckfapi::API::Sale.create(current_token, params["sale"])
      if @sale['sale']
        @sale['sale']['format_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("<b>%H:%M</b> %d/%m/%Y").html_safe
        @sale['sale']['order_created_at'] = (@sale['sale']['created_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
        @sale['sale']['format_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("<b>%H:%M</b> %d/%m/%Y").html_safe
        @sale['sale']['order_updated_at'] = (@sale['sale']['updated_at'].to_datetime + 7.hours).strftime("%Y%m%d%H%M%S")
        @sale['sale']['total_price'] = (@sale['sale']['food_sale_menu_items_details'].map{|a| a['sum'].to_i}.reduce(:+) || 0 rescue 0) + (@sale['sale']['drink_sale_menu_items_details'].map{|a| a['sum'].to_i}.reduce(:+) || 0 rescue 0)  + (@sale['sale']['service_sale_menu_items_details'].map{|a| a['sum'].to_i}.reduce(:+) || 0 rescue 0)
        WebsocketRails[:staff].trigger 'create_sale',@sale
      end
    end
    respond_to do |format|
      format.js
      format.json { render :json => { sale: @sale} }
    end
  end

  def report_sale

    @report = Ckfapi::API::Report.create(current_token,{
      title: "Customer Report",
      description: params[:report][:description],
      user_id: current_user['id'],
      model: "Sale",
      model_id: params[:report][:sale_id]
    })
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

  private

  def filter_role
    return true if ["Manager", "Cashier", "Waiter", "Customer"].include? current_user['current_role']
    redirect_to get_root_path(current_user)
  end

end
