class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.references :subdomain, null: false, foreign_key: true
      t.integer :report_type
      t.json :data
      t.references :generated_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
