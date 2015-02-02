class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create_or_update_credit_card

  def show
    @user = User.find(params[:id])
    @user_campaigns = @user.campaigns
    @journal_entries = @user.journal_entries
  end

  def create_or_update_credit_card
    current_user.create_or_update_stripe_customer(params[:stripeToken])
    flash[:notice] = "Your have successfully added a credit card."
    redirect_to(:back)
  end

  def delete_credit_card
    last4 = current_user.delete_credit_card
    flash[:notice] = "Your credit card ending in #{last4} has been deleted."
    redirect_to edit_user_registration_path
  end
end