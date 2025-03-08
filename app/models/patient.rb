class Patient < ApplicationRecord
    has_secure_password

    has_many :appointments, dependent: :destroy
    has_many :doctors, through: :appointments
    has_many :comment, dependent: :destroy

    validates :username, presence: true, uniqueness: true
    validates :username, length: { in: 3..20 }
    validates :password, presence: true
    validates :password, length: { in: 3..20 }
    # validates :password_digest, presence: true
    # validates :password_digest, length: { in: 3..20 }
    # validates :last_name, presence: true, uniqueness: true
    validates :first_name, presence: true
end
