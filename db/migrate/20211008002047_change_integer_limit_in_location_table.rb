class ChangeIntegerLimitInLocationTable < ActiveRecord::Migration[6.1]
  def change
    change_column :locations, :contact_number, :integer, limit: 8
    change_column :locations, :latitude, :float
    change_column :locations, :longitude, :float  
    change_column :patients, :contact_number, :integer, limit: 8
  end
end
