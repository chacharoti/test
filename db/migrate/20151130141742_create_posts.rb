class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.string :message
      t.integer :emotions_count, default: 0, null: false
      t.integer :comments_count, default: 0, null: false
      t.integer :followers_count, default: 0, null: false
      t.integer :interactions_count, default: 0, null: false
      t.integer :seen_users_count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
