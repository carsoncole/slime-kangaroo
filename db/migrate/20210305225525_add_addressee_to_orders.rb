class AddAddresseeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :addressee, :string
  end
end
