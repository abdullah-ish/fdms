ActiveAdmin.register Investigation do
  permit_params :subdomain_id, :iidm_admin_id, :description, :findings, :attachment

  # Filters for searching
  filter :iidm_admin, as: :select, collection: User.where(role: :iidm_admin).pluck(:name, :id)
  filter :subdomain, as: :select, collection: Subdomain.all.pluck(:name, :id)

  # Index view
  index do
    selectable_column
    column :subdomain
    column :iidm_admin
    column :description
    column :findings
    column :attachment do |investigation|
      if investigation.attachment.attached?
        link_to 'Download', rails_blob_path(investigation.attachment, disposition: 'attachment'), target: '_blank'
      else
        'No attachment'
      end
    end
    actions only: [:show, :edit]  # Limit actions to only show and edit
  end

  # Show view
  show do
    attributes_table do
      row :subdomain
      row :iidm_admin
      row :description
      row :findings
      row :attachment do |investigation|
        if investigation.attachment.attached?
          link_to investigation.attachment.filename.to_s, rails_blob_path(investigation.attachment, disposition: 'attachment'), target: '_blank'
        else
          'No attachment available'
        end
      end
    end
    active_admin_comments
  end

  # Form view
  form do |f|
    f.inputs 'Investigation Details' do
      f.input :subdomain, 
              as: :select, 
              collection: Subdomain.all, 
              include_blank: false
      f.input :iidm_admin, 
              as: :select, 
              collection: User.where(role: :iidm_admin).pluck(:name, :id), 
              include_blank: false
      f.input :description
      f.input :findings

      # Handle the file input for attachment (always show the file input for new records and existing ones)
      f.input :attachment, as: :file, 
              hint: (f.object.new_record? ? nil : (f.object.attachment.attached? ? link_to(f.object.attachment.filename, rails_blob_path(f.object.attachment, disposition: 'attachment'), target: '_blank') : 'No file attached'))
    end
    f.actions
  end

  # Remove the "New" (Create) button (redirect to index)
  controller do
    def new
      redirect_to admin_investigations_path
    end
  end

  # Limit available actions: only show and edit
  actions :index, :show, :edit, :update
end
