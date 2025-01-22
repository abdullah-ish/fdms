class CreateInvestigations < ActiveRecord::Migration[7.1]
  def change
    create_table :investigations do |t|
      t.references :subdomain, null: false, foreign_key: true
      t.references :iidm_admin, foreign_key: { to_table: :users }
      t.text :description
      t.text :findings

      t.timestamps
    end
  end
end
