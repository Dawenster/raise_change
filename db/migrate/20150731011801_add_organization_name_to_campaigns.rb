class AddOrganizationNameToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :organization_name, :string
  end
end
