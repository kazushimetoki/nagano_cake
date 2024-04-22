class Public::CustomersController < ApplicationController
 def show
  @customer = current_customer
  @public = @customer
  @item = Item.all 
 end
 
 def edit
    @customer = Customer.find(params[:id])
 end
 
 def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "Customer was successfully updated."
      redirect_to customers_mypage_path
    else
      render :edit
    end
 end
 
 def confirmation
   @customer = current_customer
 end
 
 def withdrawal
   current_customer.update(is_active: false)
   reset_session
   redirect_to root_path, notice: '退会処理が完了しました'  
 end
 
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_active) 
  end    
    
end
