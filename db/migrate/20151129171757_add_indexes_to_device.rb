class AddIndexesToDevice < ActiveRecord::Migration
  def change
    add_index :devices, :user_id
  end
end
