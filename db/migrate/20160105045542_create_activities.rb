class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :type
      t.integer :seen, default: 0, null: false
      t.integer :read, default: 0, null: false
      t.integer :deleted, default: 0, null: false
      t.string :message
      t.integer :connection_id

      t.timestamps null: false
    end

    add_index :activities, [:from_user_id, :to_user_id]
  end
end
