class ChangeColumnZipOnOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :zip, :zip_code
  end
end
