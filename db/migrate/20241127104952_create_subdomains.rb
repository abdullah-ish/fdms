class CreateSubdomains < ActiveRecord::Migration[7.1]
  def change
    create_table :subdomains do |t|
      t.string :name
      t.text :description
      t.references :local_admin, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
