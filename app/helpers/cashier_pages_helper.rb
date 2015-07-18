module CashierPagesHelper
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
