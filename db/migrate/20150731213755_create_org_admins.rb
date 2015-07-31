class CreateOrgAdmins < ActiveRecord::Migration
  def change
    create_table :org_admins do |t|
      t.belongs_to :user
      t.belongs_to :organization

      t.timestamps
    end
  end
end
