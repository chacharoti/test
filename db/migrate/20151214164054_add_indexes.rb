class AddIndexes < ActiveRecord::Migration
  def change
    add_index :posts, [:user_id]
    add_index :emotion_post_users, [:post_id]
    add_index :comment_post_users, [:post_id]
    add_index :post_user_follows, [:post_id]
  end
end
