class CreateConversationUsers < ActiveRecord::Migration
  def change
    create_table :conversation_users do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.string :status

      t.timestamps null: false
    end

    add_index :conversation_users, [:conversation_id, :user_id]
  end
end
