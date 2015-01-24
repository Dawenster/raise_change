class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :amount
      t.integer :max
      t.integer :user_id
      t.integer :campaign_id
      t.text :message

      t.timestamps
    end
  end
end
