class AddcolumnLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :image, :string
    remove_column:appointments, :time
    add_column :appointments, :time, :integer
  end
end
