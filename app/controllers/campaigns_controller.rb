class CampaignsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      flash[:notice] = "\"#{@campaign.title}\" created successfully."
      redirect_to campaign_path(@campaign)
    else
      flash.now[:alert] = @campaign.errors.full_messages.join(". ")
      render "new"
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    @campaign.assign_attributes(campaign_params)
    if @campaign.save
      flash[:notice] = "\"#{@campaign.title}\" updated successfully."
      redirect_to campaign_path(@campaign)
    else
      flash.now[:alert] = @campaign.errors.full_messages.join(". ")
      render "edit"
    end
  end

  def destroy
    campaign = Campaign.find(params[:id]).destroy
    flash[:notice] = "\"#{@campaign.title}\" has been deleted."
    redirect_to root_path
  end

  private 

  def campaign_params
    params.require(:campaign).permit(
      :title,
      :description,
      :user_id,
      :_destroy
    )
  end
end