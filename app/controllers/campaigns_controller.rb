class CampaignsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit]

  def index
    @title = "All <span class='highlight'>campaigns</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
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
    @title = "Create <span class='highlight'>campaign</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
    @center = true
  end

  def edit
    @campaign = Campaign.find(params[:id])
    @organization = @campaign.organization
    @organization.contacts.build unless @organization.contacts.any?
    @title = "Edit <span class='highlight'>campaign</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
    @center = true
  end

  def destroy
    campaign = Campaign.find(params[:id]).destroy
    flash[:notice] = "\"#{campaign.title}\" has been deleted."
    redirect_to root_path
  end
end