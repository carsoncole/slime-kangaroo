class RemovedColumnReceivedAtFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :received_at, :datetime
  end
end
