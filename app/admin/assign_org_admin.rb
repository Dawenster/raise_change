ActiveAdmin.register_page "Assign Org Admin" do
  content do
    form action: "#{add_org_admin_path}", method: "post" do
      select name: "user_email" do
        User.all.each do |user|
          option "#{user.email}"
        end
      end

      select name: "organization_name" do
        Organization.all.each do |org|
          option "#{org.name}"
        end
      end

      input class: "btn btn-default submit-button", name: "commit", type: "submit", value: "Make admin"
    end
  end
end