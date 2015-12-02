class CreateEmotionPostUsers < ActiveRecord::Migration
  def change
    create_table :emotion_post_users do |t|
      t.integer :emotion_id
      t.integer :post_id
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.integer :user_likes_count, default: 0, null: false

      t.timestamps null: false
    end

    add_index :emotion_post_users, [:emotion_id, :post_id, :user_id]
  end
end
