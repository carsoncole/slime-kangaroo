class AddPromoCodeToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :promo_code, :string
  end
end
