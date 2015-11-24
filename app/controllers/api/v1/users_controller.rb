class Api::V1::UsersController < Api::V1::BaseApiController
  before_filter :basic_authenticate, only: [:forgot_password]

  def forgot_password
    email = params[:email]
    if email.present? && user = User.find_by(email: email)
      user.send_reset_password_instructions

      render status: :ok, json: { message: "Hướng dẫn lấy lại mật khẩu đã được gửi tới email #{email}." }
    else
      render status: :bad_request, json: { error: "Email không tồn tại!" }
    end
  end
end
