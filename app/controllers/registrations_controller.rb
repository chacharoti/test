class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    if resource.save
      if resource.class == User and profile_photo_url.present?
        ProfilePhoto.create(owner: resource, file_key: profile_photo_url, 
                            thumbnail_size: profile_photo_url, 
                            normal_size: profile_photo_url )
      end

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        return render :json => {:success => true, :resource_id => resource.id}
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        return render :json => {:success => true, :resource_id => resource.id}
      end
    else
      clean_up_passwords resource
      return render :json => {:success => false}
    end
  end
 
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  private
  def profile_photo_url
    params['user']['photo_url']
  end
end