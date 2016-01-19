class RemoveContentTypeAndContentIdFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :content_type, :string
    remove_column :messages, :content_id, :integer
  end
end
