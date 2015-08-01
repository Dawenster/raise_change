ActiveAdmin.register_page "Assign Org Admin" do
  ActiveAdmin.register User do
    permit_params(
      :first_name,
      :last_name,
      :email
    )
  end

  content do
    form action: "#{add_org_admin_path}", method: "post" do
      select name: "user_email" do
        User.all.each do |user|
          option "#{user.full_name} (#{user.email})"
        end
      end

      select name: "organization_name" do
        Organization.all.each do |org|
          option org.name
        end
      end

      input class: "btn btn-default submit-button", name: "commit", type: "submit", value: "Make admin"
    end

    br

    table do
      thead do
        tr do
          th "User"
          th "Organization"
        end
      end

      tbody do
        OrgAdmin.order("user_id ASC").each do |oa|
          tr do
            td oa.user.full_name
            td oa.organization.name
          end
        end
      end
    end
  end
end