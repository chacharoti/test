class RemoveInteractionsCountFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :interactions_count, :integer
  end
end
