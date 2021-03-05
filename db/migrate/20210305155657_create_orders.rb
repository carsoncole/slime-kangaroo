class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :date
      t.decimal :amount, default: 0, null: false, scale: 2, precision: 5
      t.datetime :received_at
      t.datetime :charged_at
      t.datetime :shipped_at
      t.datetime :cancelled_at
      t.datetime :refunded_at
      t.string :email
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country

      t.timestamps
    end
  end
end
