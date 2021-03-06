class ChangePriceAndAmountRequirementsOnOrderItems < ActiveRecord::Migration[6.1]
  def change
    change_column_default :order_items, :unit_price, from: nil, to: 0
    change_column_default :order_items, :amount, from: nil, to: 0
  end
end
