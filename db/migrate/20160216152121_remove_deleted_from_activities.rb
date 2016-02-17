class RemoveDeletedFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :deleted, :integer
  end
end
