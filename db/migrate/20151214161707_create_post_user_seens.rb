class CreatePostUserSeens < ActiveRecord::Migration
  def change
    create_table :post_user_seens do |t|
      t.integer :post_id
      t.integer :user_id
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    add_index :post_user_seens, [:post_id]
  end
end
