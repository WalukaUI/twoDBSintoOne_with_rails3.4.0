class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :contact_number
      t.string :clinic_location
      t.string :role

      t.timestamps
    end
  end
end
