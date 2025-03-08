class AddColumnsTodocnpatients < ActiveRecord::Migration[6.1]
  def change
    add_column :doctors, :doctor, :boolean
    add_column :patients, :patient, :boolean
  end
end
