class AddDonationPeriodToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :donation_period, :string
  end
end
