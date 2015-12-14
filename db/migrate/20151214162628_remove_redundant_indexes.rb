class RemoveRedundantIndexes < ActiveRecord::Migration
  def change
    remove_index :emotion_post_users, [:emotion_id, :post_id, :user_id]
    remove_index :comment_post_users, [:post_id, :user_id]
  end
end
