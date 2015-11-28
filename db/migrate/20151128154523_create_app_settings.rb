class CreateAppSettings < ActiveRecord::Migration
  def change
    create_table :app_settings do |t|
      t.string :key
      t.string :value
      t.integer :is_public, default: 0, null: false

      t.timestamps null: false
    end
  end
end
