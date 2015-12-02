class CreateCommentPostUsers < ActiveRecord::Migration
  def change
    create_table :comment_post_users do |t|
      t.string :message
      t.integer :post_id
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.integer :user_likes_count, default: 0, null: false

      t.timestamps null: false
    end

    add_index :comment_post_users, [:post_id, :user_id]
  end
end
