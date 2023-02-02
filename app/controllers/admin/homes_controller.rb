class Admin::HomesController < ApplicationController
  def top
    @order_details = OrderDetail.page(params[:page]).per(10)
  end
end
