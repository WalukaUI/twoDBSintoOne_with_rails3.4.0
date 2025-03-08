class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.integer :zipcode
      t.integer :contact_number
      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end
end
