ActiveAdmin.register JournalEntry do
  permit_params(
    :dates,
    :hours,
    :description,
    :user_id,
    :campaign_id,
    :verified
  )
end
