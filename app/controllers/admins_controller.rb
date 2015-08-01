class AdminsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_filter :can_view_charity_admin_page, :only => :index

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
    redirect_to request.referrer || root_path
  end

  def index
    
  end

  private

  def can_view_charity_admin_page
    if current_user.nil? || current_user.organizations_as_admin.empty?
      flash[:alert] = "You ain't authorized yo!"
      redirect_to request.referrer || root_path
    end
  end
end