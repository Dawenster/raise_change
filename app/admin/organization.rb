ActiveAdmin.register Organization do
  permit_params(
    :name,
    :website,
    :created_at,
    :updated_at,
    :slug
  )
end
