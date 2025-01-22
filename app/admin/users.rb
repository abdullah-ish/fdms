ActiveAdmin.register User do
  permit_params :email, :name, :password, :role, subdomain_ids: []

  # Filter by role
  filter :email
  filter :role, as: :select, collection: User.roles.keys

  # Customize the columns displayed
  index do
    selectable_column
    column :id
    column :name
    column :email
    column :role do |user|
      user.role.humanize.titleize
    end
    actions
  end

  # Customize the form
  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :name
      f.input :password
      f.input :role, 
            as: :select, 
            collection: User.roles.keys.map { |role| [role.humanize.titleize, role] }, 
            include_blank: false
      f.input :subdomains, 
            as: :select, 
            collection: Subdomain.all.pluck(:name, :id), 
            input_html: { multiple: true }
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :role
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
