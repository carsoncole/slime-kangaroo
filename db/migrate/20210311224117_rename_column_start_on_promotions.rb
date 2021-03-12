class RenameColumnStartOnPromotions < ActiveRecord::Migration[6.1]
  def change
    rename_column :admin_promotions, :start, :starts_at
    rename_column :admin_promotions, :end, :ends_at
  end
end
