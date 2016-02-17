class AskForPrivateChatActivity < Activity
  belongs_to :conversation, foreign_key: 'connection_id'

  def start_new_conversation
    self.conversation = Conversation.start_new_conversation([self.from_user_id, self.to_user_id])
    self.save
  end
end
