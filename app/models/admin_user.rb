class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  # Define ransackable attributes
  def self.ransackable_attributes(auth_object = nil)
    %w[id email current_sign_in_at sign_in_count created_at]
  end
end
