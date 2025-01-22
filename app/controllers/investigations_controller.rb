class InvestigationsController < ApplicationController
  before_action :set_subdomain
  before_action :set_financial_report
  before_action :set_investigation, only: [:show, :edit, :update, :destroy]

  def index
    @investigations = @financial_report.investigations
  end

  def show
  end

  def new
    @investigation = @financial_report.investigations.new
  end

  def create
    @investigation = @financial_report.investigations.new(investigation_params)
    @investigation.iidm_admin_id = current_user.id
    @investigation.subdomain_id = @subdomain.id

    if @investigation.save
      redirect_to subdomain_financial_report_investigations_path(@subdomain, @financial_report), notice: 'Investigation created successfully.'
    else
      flash[:alert] = @investigation.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @investigation.update(investigation_params)
      redirect_to subdomain_financial_report_investigation_path(@subdomain, @financial_report, @investigation), notice: 'Investigation updated successfully.'
    else
      flash[:alert] = @investigation.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @investigation.destroy
    redirect_to subdomain_financial_report_investigations_path(@subdomain, @financial_report), notice: 'Investigation deleted successfully.'
  end

  private

  def set_subdomain
    @subdomain = Subdomain.find(params[:subdomain_id])
  end

  def set_financial_report
    @financial_report = @subdomain.financial_reports.find(params[:financial_report_id])
  end

  def set_investigation
    @investigation = @financial_report.investigations.find(params[:id])
  end

  def investigation_params
    params.require(:investigation).permit(:subdomain_id, :description, :findings, :attachment)
  end
end
