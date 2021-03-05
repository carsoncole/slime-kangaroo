class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_save :update_amount!
  after_save :update_order_amount!
  after_destroy :update_order_amount!

  def update_amount!
    self.amount = quantity * unit_price
  end

  def update_order_amount!
    order.update(amount: order.order_items.sum(:amount))
  end
end
