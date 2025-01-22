class Review < ApplicationRecord
    # Enum for status
    enum status: { pending: 0, approved: 1, rejected: 2 }
  
    # Associations
    belongs_to :subdomain
    belongs_to :public_user, class_name: 'User'
    belongs_to :investigation, optional: true
    belongs_to :financial_report, optional: true
    # Validations
    validates :content, presence: true

    def self.ransackable_attributes(auth_object = nil)
      ["id", "subdomain_id", "public_user_id", "content", "status", "created_at", "updated_at"]
    end
  
    def self.ransackable_associations(auth_object = nil)
      ["subdomain", "public_user"]
    end
  end
  