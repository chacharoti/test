class RenameEmotionsToEmotionTypes < ActiveRecord::Migration
  def change
    rename_table :emotions, :emotion_types
  end
end
