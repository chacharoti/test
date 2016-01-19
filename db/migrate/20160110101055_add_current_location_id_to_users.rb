class AddCurrentLocationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_location_id, :integer
  end
end
