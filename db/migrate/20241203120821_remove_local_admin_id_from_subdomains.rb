class RemoveLocalAdminIdFromSubdomains < ActiveRecord::Migration[7.1]
  def change
    remove_column :subdomains, :local_admin_id, :bigint
  end
end
