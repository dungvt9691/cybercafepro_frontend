module ApplicationHelper

  def update_next_state_sale token,sale_id,state
    sale = Ckfapi::API::Sale.get(token,sale_id)
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

  def mobile_device?
    request.user_agent =~ /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/
  end
end
