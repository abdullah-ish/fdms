class SubdomainsController < ApplicationController
  before_action :authenticate_user!

  # GET /subdomains
  def index
    @subdomains = current_user.subdomains
  end

  # GET /subdomains/:id
  def show
    @subdomain = current_user.subdomains.find(params[:id])
  end
end
