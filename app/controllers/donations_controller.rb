class DonationsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @donation = Donation.new
    @cards = has_credit_card? ? current_user.credit_cards : []
  end

  def create
    @campaign = Campaign.find(params[:donation][:campaign_id])
    current_user.create_or_update_stripe_customer(params[:stripeToken]) unless has_credit_card?
    @donation = Donation.new(donation_params)

    if @donation.save
      flash[:notice] = "You are now sponsoring \"#{@campaign.title}\"."
      redirect_to campaign_path(@campaign)
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
    cleanup(params).require(:donation).permit(
      :amount,
      :max,
      :message,
      :user_id,
      :campaign_id,
      :_destroy
    )
  end

  def cleanup(params)
    params[:donation][:amount] = (params[:donation][:amount].gsub("$", "").to_f * 100).to_i
    params[:donation][:max] = (params[:donation][:max].to_f * 100).to_i unless params[:donation][:max].blank?
    return params
  end
end