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

  def all_sorted_messages
    self.sorted_messages.includes(:user)
  end
end
