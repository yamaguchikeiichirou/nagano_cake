class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  def subtotal
    price * amount
  end
  enum making_status: { not_production: 0, wait_production: 1, production: 2, completed_production: 3 }
end
