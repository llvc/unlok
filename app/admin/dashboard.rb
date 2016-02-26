ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
  #  div class: "blank_slate_container", id: "dashboard_default_message" do
  #    span class: "blank_slate" do
  #      span I18n.t("active_admin.dashboard_welcome.welcome")
  #      small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #    end
  #  end

  # Recent registered users of the application
    columns do
      column do
        panel "Recent Registered Users" do
          ul do
            User.limit(5).map do |user|
              li link_to(user.email, admin_user_path(user))
            end
          end
        end
      end
    end

    # Recent Items for the dashboard
    columns do
      column do
        panel "Recent Items" do
          ul do
            Item.limit(5).map do |item|
              li link_to(item.name, admin_item_path(item))
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end

  end # content
end
