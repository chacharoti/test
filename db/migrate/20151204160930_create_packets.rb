class CreatePackets < ActiveRecord::Migration
  def change
    create_table :packets do |t|
      t.string :name
      t.integer :version
      t.string :link
      t.integer :is_public, default: 0, null: false

      t.timestamps null: false
    end
  end
end
