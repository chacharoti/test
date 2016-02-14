class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :basic_authenticate
  before_action :configure_permitted_parameters, if: :devise_controller?

  def basic_authenticate
    web_username = ENV['WEB_USERNAME']
    web_password = ENV['WEB_PASSWORD']
    if web_username.present? && web_password.present?
      authenticate_or_request_with_http_basic do |username, password|
        username == web_username && password == web_password
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :first_name, :last_name, :nickname, :birthday, :gender, :phone_number )
    end
  end
end
