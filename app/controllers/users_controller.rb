class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_campaigns = @user.campaigns
  end

  def delete_credit_card
    last4 = current_user.delete_credit_card
    flash[:notice] = "Your credit card ending in #{last4} has been deleted."
    redirect_to edit_user_registration_path
  end
end