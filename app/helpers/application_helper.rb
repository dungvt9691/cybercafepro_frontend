module ApplicationHelper

  def update_next_state_sale token,sale_id,state
    sale = Ckfapi::API::Sale.get(token, sale_id)
    if sale['sale']['next_state'] == state
      Ckfapi::API::Sale.next_state(token,sale_id)
    else
      nil
    end
  end

  def update_next_state_sale_menu_item token,sale_menu_item_id,state
    sale_menu_item = Ckfapi::API::SaleMenuItem.get(token,sale_menu_item_id)
    if sale_menu_item['sale_menu_item']['next_state'] == state
      Ckfapi::API::SaleMenuItem.next_state(token,sale_menu_item_id)
    else
      nil
    end
  end

  def redo_sale_menu_item token,sale_menu_item_id,message=""
    Ckfapi::API::SaleMenuItem.redo(current_token, sale_menu_item_id, message)
  end

  def mobile_device?
    request.user_agent =~ /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/
  end

  def extract_customer_id_from_ip ip
    csdb = CustomerDb.find_by_ip(ip)
    if csdb.nil?
      0
    else
      csdb.cs_id
    end
  end

  def sum sale
    ["food","drink","service"].inject(0) {|sum,m| sum += (sale["#{m}_sale_menu_items_details"].inject(0) {|res,e| res += e['sum'].to_f} rescue 0) }
  end

  def flash_class(level)
    case level.to_sym
    when :notice then "alert alert-success"
    when :info then "alert alert-info"
    when :alert then "alert alert-danger"
    when :warning then "alert alert-warning"
    when :success then "alert alert-success"
    end
  end

  def display_state(state)
    case state
    when "init"
      "<label class='label label-default'>Order mới</label>"
    when "pending"
      "<label class='label label-info'>Đang lấy tiền</label>"
    when "delivering"
      "<label class='label label-success'>Đang giao</label>"
    when "delivered"
      "<label class='label label-green'>Đã giao</label>"
    when "processing"
      "<label class='label label-primary'>Đã lấy tiền</label>"
    when "cooking"
      "<label class='label label-warning'>Đang làm</label>"
    when "done"
      "<label class='label label-danger'>Làm xong</label>"
    else
      "<label class='label label-inverse'>Đã lưu</label>"
    end
  end

  def render_state(state)
    case state
    when "init"
      "Order mới"
    when "pending"
      "Đang lấy tiền"
    when "delivering"
      "Đang giao"
    when "delivered"
      "Đã giao"
    when "processing"
      "Đã lấy tiền"
    when "cooking"
      "Đang làm"
    when "done"
      "Làm xong"
    else
      "Đã lưu"
    end
  end

end
