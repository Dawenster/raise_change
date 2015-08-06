class AddVerifiedToJournalEntries < ActiveRecord::Migration
  def change
    add_column :journal_entries, :verified, :boolean, :default => false
  end
end
