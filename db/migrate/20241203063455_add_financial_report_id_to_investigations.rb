class AddFinancialReportIdToInvestigations < ActiveRecord::Migration[7.1]
  def change
    add_reference :investigations, :financial_report, foreign_key: true
  end
end
