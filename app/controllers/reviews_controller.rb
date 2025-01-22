class ReviewsController < ApplicationController
  before_action :set_subdomain
  before_action :set_parent
  before_action :set_review, only: [:show, :update, :approve]

  def index
    if params[:investigation_id]
      @investigation = Investigation.find(params[:investigation_id])
      @reviews = @investigation&.reviews
    elsif params[:financial_report_id]
      @financial_report = FinancialReport.find(params[:financial_report_id])
      @reviews = @financial_report&.reviews.where(investigation_id: nil)
    end
  end

  def new
    @review = @parent&.reviews.new
  end

  def create
    if params[:investigation_id]
      @investigation = Investigation.find(params[:investigation_id])
      investigation_id = @investigation.id
    end
    @review = @parent.reviews.new(review_params)
    @review.public_user = current_user
    @review.status = :pending
    @review.subdomain_id = @subdomain.id
    if investigation_id.present?
      @review.investigation_id = investigation_id
    end

    if @review.save
      if @investigation.present?
        redirect_to subdomain_financial_report_investigation_reviews_path(@subdomain, @investigation.financial_report, @investigation), notice: 'Review submitted successfully.'
      else
        redirect_to parent_reviews_path(@parent), notice: 'Review submitted successfully.'
      end
    else
      flash[:alert] = @review.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
  end

  def update
    if @review.update(review_params)
      redirect_to parent_review_path(@parent, @review), notice: 'Review updated successfully.'
    else
      render :show
    end
  end

  def approve
    if %w[approved rejected].include?(params[:status])
      @review.update(status: params[:status])
      if @investigation.present?
        redirect_to subdomain_financial_report_investigation_reviews_path(@subdomain, @investigation.financial_report, @investigation), notice: "Review marked as #{params[:status]}."
      else
        redirect_to parent_reviews_path(@parent), notice: "Review marked as #{params[:status]}."
      end
    else
      redirect_to parent_reviews_path(@parent), alert: 'Invalid status.'
    end
  end

  private

  def set_parent
    if params[:investigation_id]
      @investigation = Investigation.find(params[:investigation_id])
      @parent = @investigation.financial_report # Assuming each investigation belongs to a financial report
    elsif params[:financial_report_id]
      @financial_report = FinancialReport.find(params[:financial_report_id])
      @parent = @financial_report
    else
      redirect_back fallback_location: root_path, alert: 'Parent not found.'
    end
  end
  

  def set_review
    @review = @parent&.reviews.find(params[:id])
  end

  def set_subdomain
    @subdomain = Subdomain.find(params[:subdomain_id])
  end

  def review_params
    params.require(:review).permit(:content, :status, :investigation_id, :financial_report_id)
  end

  def parent_reviews_path(parent)
    parent.is_a?(Investigation) ? subdomain_financial_report_investigation_reviews_path(@subdomain, parent.financial_report, parent) : subdomain_financial_report_reviews_path(@subdomain, parent)
  end

  def parent_review_path(parent, review)
    parent.is_a?(Investigation) ? subdoamin_financial_report_investigation_review_path(@subdomain,parent.financial_report, parent, review) : subdomain_financial_report_review_path(@subdomain, parent, review)
  end
end
