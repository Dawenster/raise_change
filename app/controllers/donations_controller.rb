class DonationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]
  skip_before_action :verify_authenticity_token, :only => :add_donation_message

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @donation = Donation.new
    if current_user
      @cards = has_credit_card? ? current_user.credit_cards : []
    else
      @cards = []
    end
    @title = "Donate to <span class='highlight'>#{@campaign.title}</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_food.jpg"
    @center = @campaign.title.length > 56 ? false : true
  end

  def create
    @campaign = Campaign.find(params[:donation][:campaign_id])

    if current_user
      user = current_user
    else
      user = create_and_sign_in_user
    end

    user.create_or_update_stripe_customer(params[:stripeToken]) unless has_credit_card?
    @donation = Donation.new(donation_params)
    @donation.user_id = user.id

    if @donation.save
      begin
        DonationMailer.successful_donation(@donation.id).deliver
        flash[:notice] = "Thank you! You are now supporting \"#{@campaign.title}\"."
        cookies[:just_donated] = true
        redirect_to campaign_path(@campaign)
      rescue
        flash[:alert] = "Your donation was logged but an error occured when sending you the confirmation. Please let us know at team@raisechange.com - sorry for the trouble!"
        cookies[:just_donated] = true
        redirect_to campaign_path(@campaign)
      end
    else
      flash.now[:alert] = @donation.errors.full_messages.join(". ") + "."
      render "new"
    end
  end

  def destroy
    respond_to do |format|
      donation = Donation.find(params[:id]).destroy
      flash[:notice] = "Your support has been deleted."

      url = request.referrer || root_path

      format.json { render :json => { :url => url } }
      format.html do
        redirect_to url
      end
    end
  end

  def add_donation_message
    message = params[:donation][:message]
    if message
      donation = current_user.donations.order("created_at ASC").last
      donation.update_attributes(:message => message)
    end
    flash[:notice] = "Thank you! Your message has been saved."
    redirect_to campaign_path(donation.campaign)
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