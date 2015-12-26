require 'httparty'

class Api::V1::UsersController < Api::V1::BaseApiController
  skip_before_action :require_doorkeeper_authorization, only: [:sign_up, :forgot_password, :email_is_available]
  before_filter :basic_authenticate, only: [:sign_up, :forgot_password, :email_is_available]

  def sign_up
    strong_params = user_params
    if (email = strong_params[:email]) && (fb_user_id = strong_params[:fb_user_id]) && (fb_access_token = strong_params[:fb_access_token])
      json = HTTParty.get("https://graph.facebook.com/me?access_token=#{fb_access_token}")
      if fb_user_id == eval(json.body)[:id] # valid fb_user_id and fb_access_token
        if user = User.find_by(fb_user_id: fb_user_id) # fb user exists
          user.update_attribute(:fb_access_token, fb_access_token)
          sign_up_successful(user)
        else
          if user = User.find_by(email: email) # email exists
            if password = strong_params[:password]
              if user.valid_password?(password)
                user.update_attributes(fb_user_id: fb_user_id, fb_access_token: fb_access_token)
                sign_up_successful(user)
              else
                render json: {error: "Wrong password!"}, status: :not_acceptable
              end
            else
              render json: {error: "Email exists! Please provide password for account #{email} to login!"}, status: :conflict
            end
          else
            strong_params[:password] = SecureRandom.hex(16) # random password
            sign_up_with_strong_params(strong_params)
          end
        end
      else # invalid fb_user_id and fb_access_token
        render json: {error: "Invalid data"}, status: :unprocessable_entity
      end
    else
      if user = User.find_by(email: strong_params[:email])
        render json: {error: "Email exists!"}, status: :unprocessable_entity
      else
        sign_up_with_strong_params(strong_params)
      end
    end
  end

  def forgot_password
    email = params[:email]
    if email.present? && user = User.find_by(email: email)
      user.send_reset_password_instructions

      render status: :ok, json: { message: "Change password instruction has been sent to email #{email}." }
    else
      render status: :bad_request, json: { error: "Invalid email!" }
    end
  end

  def email_is_available
    email = params[:email]
    if email.present? && User.where(email: email).exists?
      render status: :ok, json: {is_available: false, message: "Email eixts!"}
    else
      render status: :ok, json: {is_available: true}
    end
  end

  def info
    profile_info = Api::V1::Users::ProfileSerializer.new(@current_user).serializable_hash
    app_settings = AppSetting.public_items_for_user(@current_user)
    @packets = Packet.get_new_packets(params[:old_packets])
    @emotion_types = EmotionType.all

    render status: :ok, json: {profile: profile_info, app_setting: app_settings, packets: packets_json, emotion_types: emotion_types_json}
  end

  def add_media
    media = @current_user.add_media(media_params)
    for medium in media
      unless medium.valid?
        render json: {errors: medium.errors.full_messages}, status: :unprocessable_entity
        return
      end
    end

    render json: media, each_serializer: Api::V1::Posts::MediaSerializer, root: 'media'
  end

  def update_profile_photo
    photo = @current_user.update_profile_photo(profile_photo_params)

    render json: photo, serializer: Api::V1::Posts::MediaSerializer, root: 'photo'
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :email, :password, :birthday, :gender, :phone_number, :fb_user_id, :fb_access_token)
  end

  def media_params
    params.permit(media: [:type, :file_key, meta_data: [:thumbnail_size, :normal_size, :duration]]).require(:media)
  end

  def profile_photo_params
    params.require(:profile_photo).permit(:file_key, meta_data: [:thumbnail_size, :normal_size])
  end

  def sign_up_with_strong_params strong_params
    user = User.new(strong_params)
    if user.save
      sign_up_successful(user)
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def sign_up_successful user
    render status: :ok, json: {user_id: user.id}
  end

  def packets_json
    @packets.map do |packet|
      Api::V1::Packets::PacketSerializer.new(packet, root: false)
    end
  end

  def emotion_types_json
    @emotion_types.map do |emotion_type|
      Api::V1::Posts::EmotionTypeSerializer.new(emotion_type, root: false)
    end
  end
end
