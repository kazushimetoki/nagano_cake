class Admin::OrdersController < ApplicationController
  def show 
   @order = Order.find(params[:id])
  end
    
  def quantity
     self.quantity # 注文数量を返す
  end
end
