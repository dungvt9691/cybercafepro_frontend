module WaiterPagesHelper
  def get_class_menu_item(state)
    case state
    when "done"
      "danger"
    when "delivering"
      "warning"
    when "delivered"
      "success"
    end
  end

  def get_item_action_at(item)
    case item['state']
    when 'done'
      "Xong lúc: #{(item['done_at'].to_datetime + 7.hours).strftime('<b>%H:%M</b> %d/%m/%Y')}".html_safe
    when 'delivering'
      "Đi giao lúc: #{(item['delivering_at'].to_datetime + 7.hours).strftime('<b>%H:%M</b> %d/%m/%Y')}".html_safe
    when 'delivered'
      "Giao xong lúc: #{(item['delivered_at'].to_datetime + 7.hours).strftime('<b>%H:%M</b> %d/%m/%Y')}".html_safe
    else
      "Đang chờ"
    end
  end
end
