class CreateUserLocations < ActiveRecord::Migration
  def change
    create_table :user_locations do |t|
      t.integer :user_id
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
