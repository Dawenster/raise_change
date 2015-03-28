class CampaignsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit]

  def index
    @title = "All <span class='highlight'>campaigns</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/volunteer.jpg"
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find(params[:id])
    @user = @campaign.user
    @organization = @campaign.organization
  end

  def new
    @organization = Organization.new
    @organization.campaigns.build
    @organization.contacts.build
  end

  def edit
    @campaign = Campaign.find(params[:id])
    @organization = @campaign.organization
    @organization.contacts.build unless @organization.contacts.any?
  end

  def destroy
    campaign = Campaign.find(params[:id]).destroy
    flash[:notice] = "\"#{campaign.title}\" has been deleted."
    redirect_to root_path
  end
end