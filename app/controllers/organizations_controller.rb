class OrganizationsController < ApplicationController
  before_filter :authenticate_user!

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