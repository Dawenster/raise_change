class AdminsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def add_org_admin
    user = User.find_by_email(params[:user_email])
    org = Organization.find_by_slug_or_create(params[:organization_name])

    if org.admin_users.include?(user)
      flash[:notice] = "\"#{user.email}\" is already an admin for \"#{org.name}\""
    else
      OrgAdmin.create(
        :user_id => user.id,
        :organization_id => org.id
      )
      flash[:notice] = "\"#{user.email}\" added as admin to \"#{org.name}\""
    end
    redirect_to request.referrer
  end
end