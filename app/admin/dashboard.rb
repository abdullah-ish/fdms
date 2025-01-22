# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      # Users Section
      column do
        panel "<b>Users (#{User.count})</b>".html_safe do
          table_for User.all.limit(5) do
            column(:name) { |user| link_to user.name, admin_user_path(user) }
            column(:email)
            column(:role) { |user| user.role.titleize } # Capitalize and remove underscores
            column(:actions) do |user|
              links = []
              links << link_to("Show", admin_user_path(user))
              links << link_to("Edit", edit_admin_user_path(user))
              links << link_to("Delete", admin_user_path(user), method: :delete, data: { confirm: "Are you sure?" })
              safe_join(links, " | ")
            end
          end
          div link_to "View All Users", admin_users_path
        end
      end

      # Subdomains Section
      column do
        panel "<b>Subdomains (#{Subdomain.count})</b>".html_safe do
          table_for Subdomain.all.limit(5) do
            column(:name) { |subdomain| link_to subdomain.name, admin_subdomain_path(subdomain) }
            column(:description)
            column(:local_admin) do |subdomain|
              local_admin_users = subdomain.users.select { |user| user.local_admin? }
              local_admin_users&.pluck(:name).join(", ")
            end
            column(:actions) do |subdomain|
              links = []
              links << link_to("Show", admin_subdomain_path(subdomain))
              links << link_to("Edit", edit_admin_subdomain_path(subdomain))
              links << link_to("Delete", admin_subdomain_path(subdomain), method: :delete, data: { confirm: "Are you sure?" })
              safe_join(links, " | ")
            end
          end
          div link_to "View All Subdomains", admin_subdomains_path
        end
      end
    end

    columns do
      # Financial Report Section
      column do
        panel "<b>Financial Report (#{FinancialReport.count})</b>".html_safe do
          table_for FinancialReport.all.limit(5) do
            column(:data_type)
            column(:amount) { |data| number_to_currency(data.amount, unit: "$") }
            column(:uploaded_by) { |data| data.uploaded_by&.name }
            column(:actions) do |data|
              links = []
              links << link_to("Show", admin_financial_report_path(data))
              links << link_to("Edit", edit_admin_financial_report_path(data))
              safe_join(links, " | ")
            end
          end
          div link_to "View All Financial Report", admin_financial_reports_path
        end
      end

      # Investigations Section
      column do
        panel "<b>Investigations (#{Investigation.count})</b>".html_safe do
          table_for Investigation.all.limit(5) do
            column(:description)
            column(:iidm_admin) { |investigation| investigation.iidm_admin&.name }
            column(:actions) do |investigation|
              links = []
              links << link_to("Show", admin_investigation_path(investigation))
              links << link_to("Edit", edit_admin_investigation_path(investigation))
              safe_join(links, " | ")
            end
          end
          div link_to "View All Investigations", admin_investigations_path
        end
      end
    end

    columns do
      # Reviews Section
      column do
        panel "<b>Reviews (#{Review.count})</b>".html_safe do
          table_for Review.all.limit(5) do
            column(:content)
            column(:status)
            column(:public_user) { |review| review.public_user&.name }
            column(:actions) do |review|
              links = []
              links << link_to("Show", admin_review_path(review))
              links << link_to("Edit", edit_admin_review_path(review))
              links << link_to("Delete", admin_review_path(review), method: :delete, data: { confirm: "Are you sure?" })
              safe_join(links, " | ")
            end
          end
          div link_to "View All Reviews", admin_reviews_path
        end
      end
    end
  end # content
end
