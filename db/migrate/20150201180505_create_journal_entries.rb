class CreateJournalEntries < ActiveRecord::Migration
  def change
    create_table :journal_entries do |t|
      t.string :dates
      t.integer :hours
      t.text :description
      t.integer :user_id
      t.integer :campaign_id

      t.timestamps
    end
  end
end
