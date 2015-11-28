class AppSetting < ActiveRecord::Base
  def self.public_items_for_user user
    items = {}
    self.where(is_public: 1).each do |app_setting|
      items[app_setting.key] = app_setting.value.gsub!('{{user_unique_identifier}}', user.unique_identifier)
    end
    items
  end
end
