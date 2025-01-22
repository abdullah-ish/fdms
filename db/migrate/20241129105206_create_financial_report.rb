class CreateFinancialReport < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_reports do |t|
      t.references :subdomain, null: false, foreign_key: true
      t.integer :data_type, default: 0, null: false # Enum: external, internal
      t.decimal :amount, precision: 10, scale: 2
      t.text :description
      t.references :uploaded_by, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
