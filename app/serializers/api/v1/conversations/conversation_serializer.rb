class Api::V1::Conversations::ConversationSerializer < ActiveModel::Serializer
  attributes :id, :top_message_content, :top_message_created_at

  has_many :joining_users, serializer: Api::V1::UserSerializer
end
