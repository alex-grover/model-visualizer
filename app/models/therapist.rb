class Therapist < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :confirmable, :async,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups

  def self.format_therapist_full_names
    all.map { |t| t.full_name }.join(', ')
  end

  def full_name
    first_name.capitalize + ' ' + last_name.capitalize
  end

  class ParameterSanitizer < Devise::ParameterSanitizer
    def sign_up
      default_params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
end
