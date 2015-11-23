class Api::V1::DevicesController < Api::V1::BaseApiController
  before_filter :basic_authenticate, only: [:register]

  def register
    identifier = params[:device][:identifier]
    if identifier.present? && device = Device.find_by(identifier: identifier)
      device.update_attributes(device_params)
    else
      device = Device.create(device_params)
    end
    render json: { device_id: device.id }
  end

  private
  def device_params
    params.require(:device).permit(:id, :push_notification_token, :type, :identifier, :model, :os_version, :app_version)
  end

  protected
  def basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTHENTICATION_USERNAME'] && password == ENV['BASIC_AUTHENTICATION_PASSWORD']
    end
  end
end
