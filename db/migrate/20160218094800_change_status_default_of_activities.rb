class ChangeStatusDefaultOfActivities < ActiveRecord::Migration
  def change
    change_column_default(:activities, :status, '')
  end
end
