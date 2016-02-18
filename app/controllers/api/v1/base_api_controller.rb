class Api::V1::BaseApiController < ActionController::Base
  before_action :require_doorkeeper_authorization
  before_action :require_device

  def require_device
    device_id = params[:device_id]
    unless device_id.present? && @device = Device.find_by(id: device_id)
      head :unauthorized
    end
    if @current_user.present?
      @current_user.add_device(@device)
    end
  end

  def basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTHENTICATION_USERNAME'] && password == ENV['BASIC_AUTHENTICATION_PASSWORD']
    end
  end

  def require_doorkeeper_authorization
    doorkeeper_authorize!
    require_current_user
  end

  def require_current_user
    unless (doorkeeper_token.present? && @current_user ||= User.find(doorkeeper_token[:resource_owner_id]))
      head :unauthorized
    end
  end

  def require_post
    post_id = params[:id] || params[:post_id]
    unless post_id.present? && @post = Post.find_by(id: post_id)
      raise_invalid_params
    end
  end

  def require_conversation
    conversation_id = params[:id] || params[:conversation_id]
    unless conversation_id.present? && @conversation = Conversation.find_by(id: conversation_id)
      raise_invalid_params
    end
  end

  def require_activity
    activity_id = params[:id] || params[:activity_id]
    unless activity_id.present? && @activity = Activity.find_by(id: activity_id)
      raise_invalid_params
    end
  end

  def raise_invalid_params
    render json: {error: 'Invalid params'}, status: :unprocessable_entity
  end
end
