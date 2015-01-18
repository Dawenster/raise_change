class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :website
      t.string :contact_name
      t.string :contact_email

      t.timestamps
    end
  end
end
