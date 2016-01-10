class RemoveLongitudeLatitudeFromPostUserFollows < ActiveRecord::Migration
  def change
    remove_column :post_user_follows, :longitude, :float
    remove_column :post_user_follows, :latitude, :float
  end
end
