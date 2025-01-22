class Investigation < ApplicationRecord
    # Associations
    belongs_to :subdomain
    belongs_to :iidm_admin, class_name: 'User'
    belongs_to :financial_report # Add this association
    has_many :reviews, dependent: :destroy  # Add this line to establish the relationship with reviews
    # Validations
    validates :description, presence: true
    validates :findings, presence: true
    validate :attachment_presence

    has_one_attached :attachment
    def self.ransackable_attributes(auth_object = nil)
      ["id", "subdomain_id", "iidm_admin_id", "description", "findings", "created_at", "updated_at"]
    end
    
    def self.ransackable_associations(auth_object = nil)
      ["subdomain", "iidm_admin"]
    end
    private

    def attachment_presence
      errors.add(:attachment, "must be attached") unless attachment.attached?
    end
end
  