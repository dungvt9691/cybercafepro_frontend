class TemplatesController < ApplicationController
  layout "customer_layout"

  def customer_ordering
    @food_types = []
    @foods     = []
    @drinks    = []
    @services  = []

    4.times do |i|
      type = {}
      type['id'] = i + 1
      type['name'] = "Bánh Mì" if i == 0
      type['name'] = "Phở" if i == 1
      type['name'] = "Mì" if i == 2
      type['name'] = "Đồ Ăn Nhanh" if i == 3
      @food_types << type
    end

    28.times do |i|
      food = {}
      food['id'] = "#ID #{i + 1}"

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

  end
end
