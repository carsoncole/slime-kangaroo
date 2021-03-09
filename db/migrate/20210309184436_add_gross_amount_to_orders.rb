class AddGrossAmountToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :gross_amount, :decimal, precision: 5, scale: 2, default: 0, null: false
    rename_column :orders, :amount, :net_amount
  end
end
