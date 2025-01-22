ActiveAdmin.register Review do
  permit_params :subdomain_id, :public_user_id, :content, :status

  # Filter by status
  filter :status, as: :select, collection: Review.statuses.keys

  # Customize the columns displayed
  index do
    selectable_column
    column :subdomain
    column :public_user
    column :content
    column :status
    actions
  end

  # Customize the form
  form do |f|
    f.inputs 'Review Details' do
      f.input :subdomain, 
        as: :select, 
        collection: Subdomain.all, 
        include_blank: false
      f.input :public_user, 
        as: :select, 
        collection: User.where(role: :public_user).pluck(:name, :id), 
        include_blank: false
      f.input :content
      f.input :status, 
        as: :select, 
        collection: Review.statuses.keys.map { |status| [status.humanize.titleize, status] }, 
        include_blank: false
    end
    f.actions
  end
end
