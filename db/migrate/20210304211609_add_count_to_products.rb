class AddCountToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :count, :integer, default: 0, null: false
  end
end
