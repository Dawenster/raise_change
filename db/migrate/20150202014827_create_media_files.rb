class CreateMediaFiles < ActiveRecord::Migration
  def change
    create_table :media_files do |t|
      t.attachment :image
      t.string :caption
      t.integer :journal_entry_id

      t.timestamps
    end
  end
end
