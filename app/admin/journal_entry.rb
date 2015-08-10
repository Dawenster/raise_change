ActiveAdmin.register JournalEntry do
  permit_params(
    :dates,
    :hours,
    :description,
    :user,
    :campaign,
    :verified
  )

  index :as => ActiveAdmin::Views::IndexAsTable do
    column :id
    column :user
    column :campaign
    column :description
    column :dates
    column :hours
    column :verified

    actions
  end
end
