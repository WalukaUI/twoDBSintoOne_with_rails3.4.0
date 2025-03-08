class CreateDoctorLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :doctor_locations do |t|
      t.references :doctor
      t.references :location

      t.timestamps
    end
  end
end
