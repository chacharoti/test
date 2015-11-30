class Api::V1::BaseApiController < ActionController::Base
  protect_from_forgery with: :exception
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
    require_user
  end

  def require_user
    unless (doorkeeper_token.present? && @current_user ||= User.find(doorkeeper_token[:resource_owner_id]))
      head :unauthorized
    end
  end
end
