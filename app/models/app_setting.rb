class AppSetting < ActiveRecord::Base
  def self.public_items_for_user user
    items = {}
    self.where(is_public: 1).each do |app_setting|
      value = app_setting.value
      value.gsub!('{{user_unique_identifier}}', user.unique_identifier)
      items[app_setting.key] = value
    end
    items
  end
end
