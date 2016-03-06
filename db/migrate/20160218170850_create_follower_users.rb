class CreateFollowerUsers < ActiveRecord::Migration
  def change
    create_table :follower_users do |t|
      t.integer :follower_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :follower_users, [:follower_id, :user_id]
  end
end
