class AddStatusToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :status, :string, default: "waiting", null: false
  end
end
