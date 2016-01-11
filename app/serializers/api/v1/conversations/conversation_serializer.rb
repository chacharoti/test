class Api::V1::Conversations::ConversationSerializer < ActiveModel::Serializer
  attributes :id, :top_message

  has_many :joining_users, serializer: Api::V1::UserSerializer
end
