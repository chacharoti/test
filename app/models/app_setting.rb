class AppSetting < ActiveRecord::Base
  PUSHER_EVENTS = {
    new_message: "new_message"
  }
  def self.public_items_for_user user
    items = {}
    self.where(is_public: 1).each do |app_setting|
      value = app_setting.value
      value.gsub!('{{user_unique_identifier}}', user.unique_identifier)
      items[app_setting.key] = value
    end
    items
  end

  def self.media_url
    AppSetting.find_by(key: "media_url").value
  end

  def self.posts_page_size
    AppSetting.find_by(key: "posts_page_size").value.to_i
  end

  def self.nearby_people_page_size
    AppSetting.find_by(key: "nearby_people_page_size").value.to_i
  end

  def self.activities_page_size
    AppSetting.find_by(key: "activities_page_size").value.to_i
  end

  def self.inbox_page_size
    AppSetting.find_by(key: "inbox_page_size").value.to_i
  end

  def self.messages_page_size
    AppSetting.find_by(key: "messages_page_size").value.to_i
  end

  def self.start_conversation_message
    AppSetting.find_by(key: "start_conversation_message").value
  end
end
