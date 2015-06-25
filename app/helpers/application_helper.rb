module ApplicationHelper

  def update_next_state_sale sale_id,state
    sale = Ckfapi::API::Sale.get(sale_id)
    if sale['sale']['next_state'] == state
      Ckfapi::API::Sale.next_state(sale_id)
    else
      nil
    end
  end

  def update_next_state_sale_menu_item sale_menu_item_id,state
    sale_menu_item = Ckfapi::API::SaleMenuItem.get(sale_menu_item_id)
    if sale_menu_item['sale_menu_item']['next_state'] == state
      Ckfapi::API::SaleMenuItem.next_state(sale_menu_item_id)
    else
      nil
    end
  end

end
