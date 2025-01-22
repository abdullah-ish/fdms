class FinancialReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_financial_report, only: [:show, :edit, :update, :destroy]
  before_action :set_subdomain, only: [:new, :edit, :index, :show, :create, :update, :destroy]

  def index
    if @subdomain
      @financial_reports = @subdomain.financial_reports
    else
      redirect_to select_subdomain_financial_reports_path, alert: 'Subdomain not found.'
    end
  end

  def select_subdomain
    if current_user.public_user?
      @subdomains = Subdomain.all
    else
      @subdomains = current_user.subdomains
    end
  end

  def show; end

  def new
    @financial_report = current_user.financial_reports.new
  end

  def create
    @financial_report = current_user.financial_reports.new(financial_report_params)
    @financial_report.subdomain_id = @subdomain.id

    if @financial_report.save
      redirect_to subdomain_financial_report_path(@subdomain, @financial_report), notice: 'Financial report created successfully.'
    else
      flash[:alert] = @financial_report.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if @financial_report.update(financial_report_params)
      redirect_to subdomain_financial_report_path(@subdomain, @financial_report), notice: 'Financial report updated successfully.'
    else
      flash[:alert] = @financial_report.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @financial_report.destroy
    redirect_to subdomain_financial_reports_path(@subdomain), notice: 'Financial report deleted successfully.'
  end

  private

  def set_financial_report
    @financial_report = FinancialReport.find(params[:id])
  end

  def set_subdomain
    @subdomain = Subdomain.find_by(id: params[:subdomain_id])
  end

  def financial_report_params
    params.require(:financial_report).permit(:subdomain_id, :data_type, :amount, :description, :attachment)
  end
end
