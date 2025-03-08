class CreateProjectEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :project_employees do |t|
      t.integer :employee_id
      t.integer :project_id

      t.timestamps
    end
  end
end
