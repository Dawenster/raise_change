class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create_or_update_credit_card

  def show
    @user = User.find(params[:id])
    @user_campaigns = @user.campaigns
    @journal_entries = @user.journal_entries
    @donations = @user.donations
    @own_page = @user == current_user
    @title = "#{@user.first_name} <span class='highlight'>#{@user.last_name}</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/volunteer.jpg"
    @user_profile_image = true
  end

  def create_or_update_credit_card
    status = current_user.create_or_update_stripe_customer(params[:stripeToken])
    if status[:success]
      flash[:notice] = "Your have successfully added a credit card."
    else
      flash[:alert] = status[:message]
    end
    redirect_to(:back)
  end

  def delete_credit_card
    last4 = current_user.delete_credit_card
    flash[:notice] = "Your credit card ending in #{last4} has been deleted."
    redirect_to edit_user_registration_path
  end
end