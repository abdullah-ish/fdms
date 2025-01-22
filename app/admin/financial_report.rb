ActiveAdmin.register FinancialReport do
  permit_params :subdomain_id, :data_type, :amount, :description, :uploaded_by_id, :attachment

  # Filters
  filter :subdomain
  filter :data_type
  filter :uploaded_by

  # Form for edit and update only
  form do |f|
    f.inputs 'Financial Report' do
      f.input :subdomain, as: :select, collection: Subdomain.all.pluck(:name, :id)
      f.input :data_type, as: :select, collection: FinancialReport.data_types.keys
      f.input :amount, input_html: { max: 99_999_999.99 }
      f.input :description
      f.input :uploaded_by, as: :select, collection: User.where(role: :local_admin).pluck(:name, :id)
      f.input :attachment, as: :file, hint: f.object.attachment.attached? ? link_to(f.object.attachment.filename, url_for(f.object.attachment), target: "_blank") : 'No file attached'
    end
    f.actions
  end

  # Show action
  show do
    attributes_table do
      row :id
      row :subdomain
      row :data_type
      row :description
      row(:amount) { |data| number_to_currency(data.amount, unit: "$") }
      row :uploaded_by
      row :attachment do |financial_report|
        if financial_report.attachment.attached?
          link_to financial_report.attachment.filename.to_s, rails_blob_path(financial_report.attachment, disposition: 'inline'), target: '_blank'
        else
          'No attachment available'
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  # Index view
  index do
    selectable_column
    id_column
    column :subdomain
    column :data_type
    column(:amount) { |data| number_to_currency(data.amount, unit: "$") }
    column :description
    column :uploaded_by
    column :attachment do |financial_report|
      if financial_report.attachment.attached?
        link_to 'Download', rails_blob_path(financial_report.attachment, disposition: 'attachment'), target: '_blank'
      else
        'No attachment'
      end
    end
    actions
  end

  # Remove the "New" button (Create)
  controller do
    def new
      redirect_to admin_financial_reports_path
    end
  end

  # Remove the delete action from the menu
  actions :index, :show, :edit, :update
end
