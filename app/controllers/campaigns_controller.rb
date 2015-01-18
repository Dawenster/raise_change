class CampaignsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit]

  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def new
    @organization = Organization.new
    @organization.campaigns.build
    @organization.contacts.build
  end

  def edit
    @campaign = Campaign.find(params[:id])
    @organization = @campaign.organization
  end

  def destroy
    campaign = Campaign.find(params[:id])
    flash[:notice] = "\"#{campaign.title}\" has been deleted."
    redirect_to root_path
  end
end