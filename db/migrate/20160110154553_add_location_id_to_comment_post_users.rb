class AddLocationIdToCommentPostUsers < ActiveRecord::Migration
  def change
    add_column :comment_post_users, :location_id, :integer
  end
end
