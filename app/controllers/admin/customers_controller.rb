class Admin::CustomersController < ApplicationController
   
  def edit
   @customer = Customer.find(params[:id])
  end
   
    
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "Customer was successfully updated."
      redirect_to admin_customers_path
    else
      render :edit
    end
  end
  
  def index
    puts "in index"
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end

  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_active) 
  end
end
