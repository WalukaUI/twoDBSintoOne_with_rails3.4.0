class AddnewColumstoDoctors < ActiveRecord::Migration[6.1]
  def change
    add_column :doctors, :image, :string
    add_column :doctors, :isaccept_newpatients, :boolean
    add_column :doctors, :video_vistits, :boolean
  end
end
