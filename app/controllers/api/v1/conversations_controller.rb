class Api::V1::ConversationsController < Api::V1::BaseApiController
  def index
    conversations = @current_user.recent_conversations
    render_conversations(conversations)
  end

  def load_more
    last_conversation_updated_at = params[:last_conversation_updated_at].try(:to_datetime)
    if last_conversation_updated_at.present?
      conversations = @current_user.more_conversations(last_conversation_updated_at)
      render_conversations(conversations)
    else
      render json: {error: 'Invalid params'}, status: :unprocessable_entity
    end
  end

  def load_new
    first_conversation_updated_at = params[:first_conversation_updated_at].try(:to_datetime)
    if first_conversation_updated_at.present?
      conversations = @current_user.new_conversations(first_conversation_updated_at)
      render_conversations(conversations)
    else
      render json: {error: 'Invalid params'}, status: :unprocessable_entity
    end
  end

  private
  def render_conversations conversations
    render json: conversations, each_serializer: Api::V1::Conversations::ConversationSerializer, current_user: @current_user
  end
end
