class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :education
      t.string :speciality
      t.string :role
      t.timestamps
    end
  end
end
