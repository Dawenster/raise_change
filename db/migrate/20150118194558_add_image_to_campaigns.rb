class AddImageToCampaigns < ActiveRecord::Migration
  def change
    add_attachment :campaigns, :image
  end
end
