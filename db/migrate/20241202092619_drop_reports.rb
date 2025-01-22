class DropReports < ActiveRecord::Migration[7.1]
  def change
    drop_table :reports
  end
end
