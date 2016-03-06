class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:check_valid_email]

  def hot
  end

  def add_user_location
    result = get_user.update_location location_params
    render :json => {success: result}
  end

  def add_media
    updated_user = get_user
    normal_size_url.slice! AppSetting.media_url
    file_key = normal_size_url.split('_normal.jpg').first
    result = ProfilePhoto.create(owner: get_user, 
                                file_key: file_key, 
                                thumbnail_size: file_key, 
                                normal_size: file_key )
    return render :json => {:success => result}
  end

  def check_valid_email
    @user = User.find_by :email => email_params
    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  private
  def email_params
    params[:user][:email]
  end

  def user_id
    params[:id]
  end

  def get_user
    if user_id
      User.find user_id
    end
  end

  def normal_size_url
    params[:normal_size_url]
  end

  def location_params
    params.require(:location_params).permit(:latitude, :longitude)
  end
end
