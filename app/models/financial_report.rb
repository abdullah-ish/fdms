class FinancialReport < ApplicationRecord
  # Enum for data types
  enum data_type: { external: 0, internal: 1 }

  # Associations
  belongs_to :subdomain, optional: true
  belongs_to :uploaded_by, class_name: 'User'
  has_many :reviews, dependent: :destroy  
  has_many :investigations, dependent: :destroy
  has_one_attached :attachment

  # Validations
  validates :amount, presence: true
  validates :amount, numericality: { less_than: 100_000_000, message: "must be less than 100 million" }
  validates :description, presence: true

  def self.ransackable_attributes(auth_object = nil)
      ["id", "subdomain_id", "data_type", "amount", "description", "uploaded_by_id", "created_at", "updated_at"]
    end
  
    def self.ransackable_associations(auth_object = nil)
      ["subdomain", "uploaded_by"]
    end
end
