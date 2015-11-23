class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :push_notification_token
      t.string :type
      t.string :string
      t.integer :user_id
      t.string :identifier
      t.string :model
      t.string :os_version
      t.string :app_version

      t.timestamps null: false
    end
  end
end
