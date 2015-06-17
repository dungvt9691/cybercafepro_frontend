class CustomerPagesController < ApplicationController
  layout "customer_layout"

  append_view_path(File.join(Rails.root,"app/views/customer_pages"))

  def customer_ordering
    @food_types = []
    @foods     = []
    @drinks    = []
    @drink_types    = []
    @services  = []
    @service_types    = []

    4.times do |i|
      type = {}
      type['id'] = i + 1
      type['name'] = "Bánh Mì" if i == 0
      type['name'] = "Phở" if i == 1
      type['name'] = "Mì" if i == 2
      type['name'] = "Đồ Ăn Nhanh" if i == 3
      @food_types << type
    end

    4.times do |i|
      type = {}
      type['id'] = i + 1
      type['name'] = "Nước Ngọt" if i == 0
      type['name'] = "Trà Sữa" if i == 1
      type['name'] = "Cafe" if i == 2
      type['name'] = "Khác" if i == 3
      @drink_types << type
    end

    2.times do |i|
      type = {}
      type['id'] = i + 1
      type['name'] = "Nạp Tiền Game" if i == 0
      type['name'] = "Nạp thẻ ĐT" if i == 1
      @service_types << type
    end

    28.times do |i|
      food = {}
      food['id'] = "id-#{i + 1}"

      food['type_id'] = 4 if i >= 0
      food['type_id'] = 3 if i >= 7
      food['type_id'] = 2 if i >= 14
      food['type_id'] = 1 if i >= 21


      food['name'] = "Món ăn #{i + 1}"
      food['image_url'] = "http://media.foody.vn/res/g2/10645/s400x400/foody-ngo-89-tra-chanh-chem-gio-402-635684514014253271.JPG" if i >= 0
      food['image_url'] = "http://hoclambanh.ngonmoingay.org/uploads/images/news/1419784178_news_285.jpg" if i >= 7
      food['image_url'] = "http://www.hamburger.vn/images/post/2014/01/02/09//banh-hamburger-ngon-5.jpg" if i >= 14
      food['image_url'] = "http://img1.southernliving.timeinc.net/sites/default/files/styles/image__400x_variable/public/image/2009/06/one-dish-dinners/all-one-spaghetti-m.jpg" if i >= 21
      food['class'] = i % 2 == 0 ? "odd" : "even"
      food['price'] = rand(10...20) * 10000
      @foods << food


    end

    28.times do |i|
      drink = {}
      drink['id'] = "id-#{i + 1}"

      drink['type_id'] = 1 if i >= 0
      drink['type_id'] = 2 if i >= 7
      drink['type_id'] = 3 if i >= 14
      drink['type_id'] = 4 if i >= 21


      drink['name'] = "Đồ uống #{i + 1}"
      drink['image_url'] = "https://pbs.twimg.com/profile_images/493592781575557120/H7R37Fc8_400x400.jpeg" if i >= 0
      drink['image_url'] = "http://media.store123doc.com:8080/images/blog/15/br/ke/larger_xup1424579826.jpg" if i >= 7
      drink['image_url'] = "http://media.foody.vn/res/g1/4085/s400x400/foody-checkin-highlands-coffee-nguyen-du-564-635611099244679970.JPG" if i >= 14
      drink['image_url'] = "http://img.21food.com/img/images/2013/2/20/sunico-11380010.jpg" if i >= 21
      drink['class'] = i % 2 == 0 ? "odd" : "even"
      drink['price'] = rand(10...20) * 10000
      @drinks << drink
    end

    14.times do |i|
      service = {}
      service['id'] = "id-#{i + 1}"

      service['type_id'] = 1 if i >= 0
      service['type_id'] = 2 if i >= 7


      service['name'] = "Dịch vụ #{i + 1}"
      service['image_url'] = "http://www.thegoichatluong.soz.vn/upload/userfiles/thegoichatluong/images/sanpham/2013630113955soz.jpg" if i >= 0
      service['image_url'] = "http://vatgia.com/raovat_pictures/1/nqu1364182205.jpeg" if i >= 7
      service['class'] = i % 2 == 0 ? "odd" : "even"
      service['price'] = rand(10...20) * 10000
      @services << service
    end

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
