class Api::V1::BaseApiController < ActionController::Base

  protected
  def basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTHENTICATION_USERNAME'] && password == ENV['BASIC_AUTHENTICATION_PASSWORD']
    end
  end
end
