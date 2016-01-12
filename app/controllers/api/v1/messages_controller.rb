class Api::V1::MessagesController < Api::V1::BaseApiController
  before_action :require_conversation, only: [:index]

  def index
    messages = @conversation.all_sorted_messages
    render_messages(messages)
  end

  private
  def render_messages messages
    render json: messages, each_serializer: Api::V1::Messages::MessageSerializer
  end
end
