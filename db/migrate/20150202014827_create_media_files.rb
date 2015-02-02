class CreateMediaFiles < ActiveRecord::Migration
  def change
    create_table :media_files do |t|
      t.attachment :image
      t.string :caption

      t.timestamps
    end
  end
end
