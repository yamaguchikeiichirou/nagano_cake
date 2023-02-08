class Public::AddressesController < ApplicationController
  def index
  end

  def edit
  end
  
  def create
  end
  
  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, )
  end
  
end
