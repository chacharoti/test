class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/users.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
    end
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @users is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      flash[:error] = "The facebook's email is used to register. Please use another one!"
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end