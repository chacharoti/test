class Api::V1::MessagesController < Api::V1::BaseApiController
  before_action :require_conversation, only: [:index, :load_more, :create]
  before_action :validate_conversation_owner, only: [:index, :load_more, :create]

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

  def create
    message = @conversation.add_message(create_message_params, @current_user)
    if message.valid?
      render json: {message_id: message.id}, status: :ok
    else
      render json: {errors: message.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
  def render_messages messages
    render json: messages, each_serializer: Api::V1::Messages::MessageSerializer
  end

  def validate_conversation_owner
    unless @current_user.joining_conversations.exists?(@conversation.id)
      raise_invalid_params
    end
  end

  def create_message_params
    params.require(:message).require(:content_type)
    params.require(:message).require(:content_attributes)
    content_type = params[:message][:content_type]
    if content_type == 'Text'
      params.require(:message).require(:content_attributes).require(:raw)
      return params.require(:message).permit(:content_type, content_attributes: [:raw])
    elsif content_type == 'Photo'
      params.require(:message).require(:content_attributes).require(:file_key)
      params.require(:message).require(:content_attributes).require(:meta_data).require(:thumbnail_size)
      params.require(:message).require(:content_attributes).require(:meta_data).require(:normal_size)
      return params.require(:message).permit(:content_type, content_attributes: [:file_key, meta_data: [:thumbnail_size, :normal_size]])
    elsif content_type == 'Video'
      params.require(:message).require(:content_attributes).require(:file_key)
      params.require(:message).require(:content_attributes).require(:meta_data).require(:thumbnail_size)
      params.require(:message).require(:content_attributes).require(:meta_data).require(:duration)
      return params.require(:message).permit(:content_type, content_attributes: [:file_key, meta_data: [:thumbnail_size, :duration]])
    elsif content_type == 'Audio'
      params.require(:message).require(:content_attributes).require(:file_key)
      params.require(:message).require(:content_attributes).require(:meta_data).require(:duration)
      return params.require(:message).permit(:content_type, content_attributes: [:file_key, meta_data: [:duration]])
    else
      raise_invalid_params
    end
  end
end
