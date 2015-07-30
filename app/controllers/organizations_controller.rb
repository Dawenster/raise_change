class OrganizationsController < ApplicationController
  before_filter :authenticate_user!

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

  def update
    @organization = Organization.find(params[:id])
    @organization.assign_attributes(organization_params)
    if @organization.save
      @campaign = @organization.campaigns.last
      flash[:notice] = "\"#{@campaign.title}\" updated successfully."
      redirect_to campaign_path(@campaign)
    else
      flash.now[:alert] = @organization.errors.full_messages.join(". ") + "."
      render "campaigns/edit"
    end
  end

  private 

  def organization_params
    params.require(:organization).permit(
      :id,
      :name,
      :website,
      :_destroy,
      campaigns_attributes: [
        :id,
        :title,
        :description,
        :user_id,
        :organization_id,
        :image,
        :donation_period,
        :_destroy
      ],
      contacts_attributes: [
        :id,
        :name,
        :email,
        :organization_id,
        :_destroy
      ]
    )
  end
end