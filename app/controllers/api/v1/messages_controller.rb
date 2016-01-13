class Api::V1::MessagesController < Api::V1::BaseApiController
  before_action :require_conversation, only: [:index, :load_more]

  def index
    messages = @conversation.recent_sorted_messages
    render_messages(messages)
  end

  def load_more
    last_message_id = params[:last_message_id].try(:to_i)
    if last_message_id.present? && last_message_id > 0
      messages = @conversation.more_sorted_messages(last_message_id)
      render_messages(messages)
    else
      raise_invalid_params
    end
  end

  private
  def render_messages messages
    render json: messages, each_serializer: Api::V1::Messages::MessageSerializer
  end
end
