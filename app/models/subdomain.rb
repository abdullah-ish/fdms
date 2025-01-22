class Subdomain < ApplicationRecord
  # Associations
  has_and_belongs_to_many :users, join_table: :users_subdomains
  has_many :financial_reports, class_name: 'FinancialReport', dependent: :destroy
  has_many :investigations
  has_many :reviews

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Callbacks
  before_save :sanitize_name

  # Ransackable attributes for search functionality
  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["local_admin"]
  end

  private

  # Ensure the name contains only lowercase alphanumeric characters
  def sanitize_name
    if name.present?
      # Remove all non-alphanumeric characters and convert to lowercase
      self.name = name.gsub(/[^a-zA-Z0-9]/, '').downcase
    end
  end
end
