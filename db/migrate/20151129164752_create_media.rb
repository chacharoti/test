class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :owner_type
      t.integer :owner_id
      t.string :file_key
      t.string :type

      t.timestamps null: false
    end

    add_index :media, [:owner_type, :owner_id], name: 'media_indexes'
  end
end
