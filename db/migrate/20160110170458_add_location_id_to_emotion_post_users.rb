class AddLocationIdToEmotionPostUsers < ActiveRecord::Migration
  def change
    add_column :emotion_post_users, :location_id, :integer
  end
end
