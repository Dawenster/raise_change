class AddEstimatedHoursAndFrequencyToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :estimated_hours, :integer
    add_column :campaigns, :frequency, :string
  end
end
