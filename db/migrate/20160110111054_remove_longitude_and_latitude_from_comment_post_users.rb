class RemoveLongitudeAndLatitudeFromCommentPostUsers < ActiveRecord::Migration
  def change
    remove_column :comment_post_users, :longitude, :float
    remove_column :comment_post_users, :latitude, :float
  end
end
