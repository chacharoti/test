class AddLocationIdToPostUserFollows < ActiveRecord::Migration
  def change
    add_column :post_user_follows, :location_id, :integer
  end
end
