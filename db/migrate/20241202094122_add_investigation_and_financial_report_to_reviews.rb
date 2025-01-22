class AddInvestigationAndFinancialReportToReviews < ActiveRecord::Migration[7.1]
  def change
    add_reference :reviews, :investigation, foreign_key: true, null: true
    add_reference :reviews, :financial_report, foreign_key: true, null: true
  end
end
