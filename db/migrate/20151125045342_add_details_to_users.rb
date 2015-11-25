class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :integer
    add_column :users, :phone_number, :string
    add_column :users, :fb_user_id, :string
    add_column :users, :fb_access_token, :string
  end
end
