class Public::HomesController < ApplicationController
    
  def top
    @items = Item.all.order(created_at: :desc).limit(4)
  end
  
  def about
    @orders = Order.all
  end
end
