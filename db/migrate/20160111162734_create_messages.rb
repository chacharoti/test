class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.datetime :editted_at
      t.datetime :deleted_at
      t.string :status
      t.integer :content_id
      t.string :content_type

      t.timestamps null: false
    end

    add_index :messages, [:conversation_id]
  end
end
