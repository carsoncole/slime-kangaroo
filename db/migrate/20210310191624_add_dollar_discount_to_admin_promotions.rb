class AddDollarDiscountToAdminPromotions < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_promotions, :discount_dollars, :decimal, precision: 5, scale: 2
  end
end
