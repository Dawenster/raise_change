class OrganizationsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    if @donation.save
      campaign = @donation.campaign
      flash[:notice] = "You are now sponsoring \"#{campaign.title}\"."
      redirect_to campaign_path(campaign)
    else
      flash.now[:alert] = @donation.errors.full_messages.join(". ") + "."
      render "new"
    end
  end

  def destroy
    donation = Donation.find(params[:id]).destroy
    flash[:notice] = "Your donation has been deleted."
    redirect_to root_path
  end

  private 

  def donation_params
    params.require(:donation).permit(
      :amount,
      :max,
      :message,
      :user_id,
      :campaign_id,
      :_destroy
    )
  end
end