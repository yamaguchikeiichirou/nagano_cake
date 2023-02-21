class Public::ItemsController < ApplicationController
   before_action :authenticate_customer!, except: [:index]
  
  def index
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :image)
  end

end
