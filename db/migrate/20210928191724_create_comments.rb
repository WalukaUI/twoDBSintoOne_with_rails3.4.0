class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :doctor
      t.references :patient
      t.string :comment
      t.integer :points

      t.timestamps
    end
  end
end
