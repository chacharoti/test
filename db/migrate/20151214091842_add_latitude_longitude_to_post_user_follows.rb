class AddLatitudeLongitudeToPostUserFollows < ActiveRecord::Migration
  def change
    add_column :post_user_follows, :latitude, :float
    add_column :post_user_follows, :longitude, :float
  end
end
