class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  def subtotal
    item.price_tax * amount
  end
end
