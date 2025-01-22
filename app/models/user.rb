class User < ApplicationRecord
  # Devise authentication modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  # Enum for user roles
  enum role: { local_admin: 0, iidm_admin: 1, public_user: 2 }

  # Associations
  has_and_belongs_to_many :subdomains, join_table: :users_subdomains
  has_many :financial_reports, class_name: 'FinancialReport', foreign_key: 'uploaded_by_id', dependent: :destroy
  has_many :investigations, foreign_key: :iidm_admin_id, dependent: :destroy
  has_many :reviews, foreign_key: :public_user_id, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  # Define ransackable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "email", "role", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    [] # Add associations here if any need to be searchable.
  end
end
