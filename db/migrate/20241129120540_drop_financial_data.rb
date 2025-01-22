class DropFinancialData < ActiveRecord::Migration[7.1]
  def change
    drop_table :financial_data
  end
end
