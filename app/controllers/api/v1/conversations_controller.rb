class Api::V1::ConversationsController < Api::V1::BaseApiController
  def index
    conversations = @current_user.recent_conversations

    render json: conversations, each_serializer: Api::V1::Conversations::ConversationSerializer, current_user: @current_user
  end
end
