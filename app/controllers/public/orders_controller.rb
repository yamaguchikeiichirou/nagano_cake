class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def verification
    @order = Order.new(order_params)
    if params[:order][:address_choice] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:address_choice] == "1"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    elsif params[:order][:address_choice] == "2"
    end
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @order.shipping_cost + @total.round
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item.id
      @order_detail.order_id = @order.id
      @order_detail.price = cart_item.item.price_tax
      @order_detail.amount = cart_item.amount
      @order_detail.making_status = 0
      @order_detail.save
    end
    redirect_to orders_completed_path
  end

  def completed
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.includes(:item)
    @total = @order_details.sum(&:subtotal)
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
