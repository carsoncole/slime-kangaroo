class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.uuid :order_id
      t.integer :product_id
      t.integer :quantity, default: 0, null: false
      t.decimal :unit_price, scale: 2, precision: 5
      t.decimal :amount, scale: 2, precision: 5

      t.timestamps
    end
  end
end
