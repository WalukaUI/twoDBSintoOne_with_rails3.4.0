class ChangeTimeInappointment < ActiveRecord::Migration[6.1]
  def change
    remove_column:appointments, :time
    add_column :appointments, :bookingtime, :float
  end
end
