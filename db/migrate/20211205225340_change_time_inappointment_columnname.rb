class ChangeTimeInappointmentColumnname < ActiveRecord::Migration[6.1]
  def change
    remove_column:appointments, :bookingtime
    add_column :appointments, :time, :float
  end
end
