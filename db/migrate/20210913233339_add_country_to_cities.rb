class AddCountryToCities < ActiveRecord::Migration[6.1]
  def change
    remove_column :cities, :country_id
    add_reference :cities, :country, null: false, foreign_key: true
  end
end
