class AdminsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_filter :can_view_charity_admin_page, :only => :index

  def add_org_admin
    user = User.find(params[:user_id])
    org = Organization.find_by_slug_or_create(params[:organization_name])

    if org.admin_users.include?(user)
      flash[:notice] = "\"#{user.full_name}\" is already an admin for \"#{org.name}\""
    else
      OrgAdmin.create(
        :user_id => user.id,
        :organization_id => org.id
      )
      flash[:notice] = "\"#{user.full_name}\" added as admin to \"#{org.name}\""
    end
    redirect_to request.referrer || root_path
  end

  def index
    
  end

  def verify
    respond_to do |format|
      JournalEntry.find(params[:journal_entry_id]).update_attributes(:verified => true)
      format.json { render :json => { :status => 200 } }
    end
  end

  def verify_all
    respond_to do |format|
      Organization.find(params[:org_id]).journal_entries.where(:verified => false).each do |entry|
        entry.update_attributes(:verified => true)
      end
      format.json { render :json => { :status => 200 } }
    end
  end

  private

  def can_view_charity_admin_page
    if current_user.nil? || current_user.organizations_as_admin.empty?
      flash[:alert] = "You ain't authorized yo!"
      redirect_to request.referrer || root_path
    end
  end
end