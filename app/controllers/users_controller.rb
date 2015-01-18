class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_campaigns = @user.campaigns
  end
end