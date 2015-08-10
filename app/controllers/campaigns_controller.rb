class CampaignsController < ApplicationController
  autocomplete :organization, :name, :full => true
  
  before_filter :authenticate_user!, :only => [:new, :edit]
  before_filter :authorized_user, :only => [:edit, :update, :destroy]

  def index
    @title = "All <span class='highlight'>campaigns</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find(params[:id])
    @user = @campaign.user
    @organization = @campaign.organization
    @share_html_as_string = render_to_string(:template => ('layouts/_share_this_buttons.html.slim'), :layout => false, :locals => {:campaign => @campaign} )
  end

  def new
    @campaign = Campaign.new
    @title = "Create <span class='highlight'>campaign</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
    @center = true
  end

  def create
    @campaign = Campaign.new(campaign_params)
    org = Organization.find_by_slug_or_create(params[:campaign][:organization_name])
    @campaign.organization_id = org.id
    if @campaign.save
      flash[:notice] = "\"#{@campaign.title}\" created successfully."
      cookies[:just_created] = true
      redirect_to campaign_path(@campaign)
    else
      flash.now[:alert] = @campaign.errors.full_messages.join(". ") + "."
      render "new"
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
    @campaign = Campaign.find(params[:id])
    @campaign.assign_attributes(campaign_params)
    org = Organization.find_by_slug_or_create(params[:campaign][:organization_name])
    @campaign.organization_id = org.id
    if @campaign.save
      flash[:notice] = "\"#{@campaign.title}\" updated successfully."
      redirect_to campaign_path(@campaign)
    else
      flash.now[:alert] = @campaign.errors.full_messages.join(". ") + "."
      render "edit"
    end
  end

  def destroy
    campaign = Campaign.find(params[:id]).destroy
    flash[:notice] = "\"#{campaign.title}\" has been deleted."
    redirect_to root_path
  end

  private 

  def campaign_params
    params.require(:campaign).permit(
      :id,
      :organization_name,
      :title,
      :description,
      :user_id,
      :organization_id,
      :image,
      :donation_period,
      :estimated_hours,
      :frequency,
      :_destroy
    )
  end

  def authorized_user
    @campaign = Campaign.find(params[:id])
    if current_user && ((@campaign.user != current_user) || !current_user.admin)
      flash[:alert] = "You are not authorized to view this page"
      redirect_to campaign_path(@campaign)
    end
  end
end