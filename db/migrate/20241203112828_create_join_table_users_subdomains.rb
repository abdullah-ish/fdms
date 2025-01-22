class CreateJoinTableUsersSubdomains < ActiveRecord::Migration[7.1]
  def change
    create_table :users_subdomains do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subdomain, null: false, foreign_key: true

      t.timestamps
    end
  end
end
