class ChangeEmotionIdToEmotionTypeId < ActiveRecord::Migration
  def change
    rename_column :emotion_post_users, :emotion_id, :emotion_type_id
  end
end
