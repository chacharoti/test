class CreatePostUserFollows < ActiveRecord::Migration
  def change
    create_table :post_user_follows do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
