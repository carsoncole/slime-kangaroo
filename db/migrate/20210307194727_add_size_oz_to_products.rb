class AddSizeOzToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :size_oz, :decimal, precision: 5, scale: 2
  end
end
