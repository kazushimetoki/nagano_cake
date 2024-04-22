class Item < ApplicationRecord
  has_one_attached :image
  
  # devise :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :validatable
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    self.image.variant(resize_to_limit: [400, 400]).processed
  end
  
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
end
