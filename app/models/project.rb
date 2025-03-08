class Project < ApplicationRecord
    has_many :project_employees
    has_many :employees, through: :project_employees
end
