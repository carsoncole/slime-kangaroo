class AddShippingInfoToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :shipping_tracking_id, :string
    add_column :orders, :shipping_method, :string
  end
end
