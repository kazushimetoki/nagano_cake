class Public::OrdersController < ApplicationController
    
  def new
    @order = Order.new    
  end
  
  def index
    @orders = Order.page(params[:page])
  end
  
  def create
   @order = Order.new(order_params)
   @cart_items = current_customer.cart_items.all
   @order.customer_id = current_customer.id
   @order.postal_code = current_customer.postal_code
   @order.shipping_postal_code = current_customer.postal_code
   @order.shipping_address = current_customer.address
   @order.delivery_name = current_customer.first_name + current_customer.last_name
   @order.save!
    @cart_items.each do |cart|
    @order_detail = OrderDetail.new
    @order_detail.item_id = cart.item_id
    @order_detail.order_id = @order.id
    @order_detail.quantity = cart.amount
    @order_detail.product_purchase_price = cart.item.price*1.1
    @order_detail.save!
   end
   current_customer.cart_items.destroy_all
   redirect_to orders_completion_path
  end
  
  def show
   if params[:id] == 'confirmation'
    @order = current_customer.orders.last
   else
    @order = Order.find(params[:id])
   end
  end
  
  def confirmation
   @order = Order.new(order_params)
   #binding.pry #追記する
   @order.postal_code = current_customer.postal_code
   @order.shipping_address = current_customer.address
   @order.delivery_name = current_customer.first_name + current_customer.last_name
   @cart_items = current_customer.cart_items 
   @total =  @cart_items.inject(0) {|sum,cart_item|sum + cart_item.sub_total}
   #byebug
  end
 
 def completion
  
 end
   
  private
  
  def order_params
   params.require(:order).permit(:payment_method, :total_billing_amount, :postage)
  end
  
  
  
end
