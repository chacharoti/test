class Conversation < ActiveRecord::Base
  has_many :conversation_users, dependent: :destroy
  has_many :users, through: :conversation_users
  has_many :joining_conversation_users, -> { joining }, class_name: 'ConversationUser'
  has_many :joining_users, through: :joining_conversation_users, source: :user
  has_many :messages, dependent: :destroy
  has_many :sorted_messages, -> { available.sorted }, class_name: 'Message'
  has_one :top_message, -> { available.sorted.limit(1) }, class_name: 'Message'

  def top_message_content
    self.top_message.try(:content_summary)
  end

  def top_message_created_at
    self.top_message.try(:created_at)
  end

  def recent_sorted_messages
    self.sorted_messages.includes(:user, :text, :photo, :video, :audio).limit(AppSetting.messages_page_size)
  end

  def more_sorted_messages last_message_id
    self.recent_sorted_messages.where('messages.id < ?', last_message_id)
  end

  def add_message message_params, user
    self.messages.create(message_params.merge(user_id: user.id))
  end

  def self.start_new_conversation user_ids
    conversation = Conversation.create
    conversation.joining_users = User.where('id IN (?)', user_ids)
    message = conversation.messages.create
    message.create_text(raw: AppSetting.start_conversation_message)
    conversation
  end
end
