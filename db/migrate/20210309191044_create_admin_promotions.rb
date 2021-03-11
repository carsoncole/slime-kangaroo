class CreateAdminPromotions < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_promotions do |t|
      t.string :code
      t.string :name
      t.integer :discount_percentage
      t.datetime :start
      t.datetime :end
      t.boolean :has_free_shipping, default: false

      t.timestamps
    end
  end
end
