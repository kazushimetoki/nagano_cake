class Order < ApplicationRecord
    enum payment_method: { credit_card: 0, transfer: 1 }
    belongs_to :customer
    has_many :order_details
    
    def full_address
        self.postal_code + ' ' + self.shipping_address
    end
    
end
