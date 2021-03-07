class AddMasterProductIdIntegerToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :master_product_id, :integer
  end
end
