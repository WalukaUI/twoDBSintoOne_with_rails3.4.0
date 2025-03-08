class Location < ApplicationRecord
    has_many :doctor_locations
    has_many :doctors, through: :doctor_locations

    validates :name, presence: true 
    validates :longitude, presence: true 
    validates :latitude, presence: true  
    
end
