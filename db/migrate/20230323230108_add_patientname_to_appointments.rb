class AddPatientnameToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :patientname, :string
  end
end
