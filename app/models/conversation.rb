class Conversation < ActiveRecord::Base
  has_many :conversation_users, dependent: :destroy
  has_many :users, through: :conversation_users
  has_many :joining_conversation_users, -> { joining }, class_name: 'ConversationUser'
  has_many :joining_users, through: :joining_conversation_users, source: :user

  def top_message
    'This is a top message, will be changed later'
  end
end
