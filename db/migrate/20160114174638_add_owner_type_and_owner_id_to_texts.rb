class AddOwnerTypeAndOwnerIdToTexts < ActiveRecord::Migration
  def change
    add_column :texts, :owner_type, :string
    add_column :texts, :owner_id, :integer
    add_index :texts, [:owner_type, :owner_id]
  end
end
