class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :product_id
      t.decimal :price

      t.timestamps
    end
  end
end