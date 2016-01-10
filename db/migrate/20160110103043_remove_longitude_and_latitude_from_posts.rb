class RemoveLongitudeAndLatitudeFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :longitude, :float
    remove_column :posts, :latitude, :float
  end
end
