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

end
