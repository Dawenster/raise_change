ActiveAdmin.register User do
  permit_params(
    :first_name,
    :last_name,
    :email,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :created_at,
    :updated_at,
    :provider,
    :uid,
    :stripe_id,
    :admin
  )

  show do |user|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :created_at
      row :updated_at
      row :provider
      row :uid
      row :stripe_id
    end
    active_admin_comments
  end
end
