class CommentPointsToFlote < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :points, :float
  end
end
