class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :subdomain, null: false, foreign_key: true
      t.references :public_user, foreign_key: { to_table: :users }
      t.text :content
      t.integer :status

      t.timestamps
    end
  end
end
