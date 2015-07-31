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
    @campaign = Campaign.new
    @title = "Create <span class='highlight'>campaign</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
    @center = true
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      campaign = @organization.campaigns.last
      flash[:notice] = "\"#{campaign.title}\" created successfully."
      redirect_to campaign_path(campaign)
    else
      flash.now[:alert] = @organization.errors.full_messages.join(". ") + "."
      render "campaigns/new"
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
    @organization = @campaign.organization
    @organization.contacts.build unless @organization.contacts.any?
    @title = "Edit <span class='highlight'>campaign</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
    @center = true
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.assign_attributes(organization_params)
    campaign = @organization.campaigns.last
    if @organization.save
      flash[:notice] = "\"#{campaign.title}\" updated successfully."
      redirect_to campaign_path(campaign)
    else
      flash[:alert] = @organization.errors.full_messages.join(". ") + "."
      redirect_to edit_campaign_path(campaign)
    end
  end

  def destroy
    campaign = Campaign.find(params[:id]).destroy
    flash[:notice] = "\"#{campaign.title}\" has been deleted."
    redirect_to root_path
  end
end