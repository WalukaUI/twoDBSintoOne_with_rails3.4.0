class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :client_name
      t.string :sector
      t.integer :start_date
      t.integer :end_date
      t.integer :cost

      t.timestamps
    end
  end
end
