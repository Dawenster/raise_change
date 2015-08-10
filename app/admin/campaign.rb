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
end
