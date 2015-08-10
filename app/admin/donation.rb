ActiveAdmin.register Donation do
  permit_params(
    :amount,
    :max,
    :user_id,
    :campaign_id,
    :message,
  )
end
