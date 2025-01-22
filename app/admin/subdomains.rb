ActiveAdmin.register Subdomain do
  permit_params :name, :description, user_ids: []

  # Filter by local_admin
  filter :local_admin
  filter :name

  # Customize the columns displayed
  index do
    selectable_column
    column :id
    column :name
    column :description
    column :local_admins do |subdomain|
      # Retrieve all users with role `local_admin` associated with the subdomain
      subdomain.users.where(role: :local_admin).pluck(:name).join(", ")
    end
    actions
  end

  # Customize the form
  form do |f|
    f.inputs 'Subdomain Details' do
      f.input :name
      f.input :description
      f.input :users, 
        as: :select, 
        collection: User.where(role: :local_admin).pluck(:name, :id), 
        include_blank: false,
        input_html: { multiple: true },
        label: "Local Users"
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :local_admins do |subdomain|
        # Retrieve all users with role `local_admin` associated with the subdomain
        subdomain.users.where(role: :local_admin).pluck(:name).join(", ")
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
