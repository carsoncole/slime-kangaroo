class RemoveColumnEmailFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :email, :string
  end
end
