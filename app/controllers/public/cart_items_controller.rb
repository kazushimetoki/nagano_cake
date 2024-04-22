class Public::CartItemsController < ApplicationController

 def index
  @cart_items = current_customer.cart_items 
  @total =  @cart_items.inject(0) {|sum,cart_item|sum + cart_item.sub_total}
 end
 
 def create
  cart_item = CartItem.new(cart_item_params)
    if CartItem.find_by(item_id: params[:cart_item][:item_id],customer_id: current_customer.id).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id],customer_id: current_customer.id)
      sum = cart_item.amount + params[:cart_item][:amount].to_i

      cart_item.update(amount: sum)
    else
     cart_item.customer_id = current_customer.id
     cart_item.save
    end
    redirect_to cart_items_path
 end 
 def destroy
    cart_item = CartItem.find(params[:id])  # データ（レコード）を1件取得
    cart_item.destroy  # データ（レコード）を削除
    redirect_to '/cart_items'  # 投稿一覧画面へリダイレクト  
 end
 
 def destroy_all
  current_customer.cart_items.destroy_all
  redirect_to '/cart_items' 
 end
 
 def update
  cart_item = CartItem.find(params[:id])
  if cart_item.update(cart_item_params)
      flash[:notice] = "Customer was successfully updated."
      redirect_to cart_items_path
  else
   render :edit
  end
 end
 
 private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
  
end
