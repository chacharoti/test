class AddMetaDataToMedia < ActiveRecord::Migration
  def change
    add_column :media, :meta_data, :text
  end
end
