ActiveAdmin.register Donation do
  permit_params(
    :amount,
    :max,
    :user_id,
    :campaign_id,
    :message
  )

  index :as => ActiveAdmin::Views::IndexAsTable do
    column :id
    column :user
    column :campaign
    column :amount
    column :max
    column :message

    actions
  end
end
