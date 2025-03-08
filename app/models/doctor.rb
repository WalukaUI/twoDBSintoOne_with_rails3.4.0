class Doctor < ApplicationRecord
    has_secure_password
    
    has_many :doctor_locations
    has_many :locations, through: :doctor_locations

    has_many :appointments
    has_many :patients, through: :appointments

    has_many :comment

    validates :last_name, uniqueness: true
    validates :last_name, presence: true 
    validates :first_name, presence: true 
    validates :speciality, presence: true 
end
