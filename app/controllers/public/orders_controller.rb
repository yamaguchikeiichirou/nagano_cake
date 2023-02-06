class Public::OrdersController < ApplicationController
  def new
    @odrer = Order.new
  end
  
  def verification
    @odrer = Order.new(order_params)
    @odrer.save
    redirect_to 
  end


  def index
  end

  def show
  end

  def completed
  end
  
  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
  
end
