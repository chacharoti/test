class RemoveLongitudeLatitudeFromEmotionPostUsers < ActiveRecord::Migration
  def change
    remove_column :emotion_post_users, :longitude, :float
    remove_column :emotion_post_users, :latitude, :float
  end
end
