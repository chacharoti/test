class Api::V1::DevicesController < Api::V1::BaseApiController

  def register
    identifier = params[:device][:identifier]
    if identifier.present? && device = Device.find_by(identifier: identifier)
      device.update_attributes(device_params)
    else
      device = Device.create(device_params)
    end
    render json: { device_id: device.id }
  end
end
