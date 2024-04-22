class CartItem < ApplicationRecord
  has_one_attached :image  
  belongs_to :customer
  belongs_to :item
  
  def cart_item
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def sub_total
    amount*item.price*1.1
  end
end
