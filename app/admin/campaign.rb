ActiveAdmin.register Campaign do
  permit_params(
    :title,
    :description,
    :user_id,
    :organization_id,
    :donation_period,
    :organization_name,
    :estimated_hours,
    :frequency
  )

  index :as => ActiveAdmin::Views::IndexAsTable do
    column :title
    column :description
    column :user
    column :organization
    column :estimated_hours
    column :frequency
    column :created_at
    column :updated_at
  end
end
