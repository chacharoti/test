class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)
    if resource && resource.active_for_authentication?
      sign_in_and_redirect(resource_name, resource)
    else
      failure
    end
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render :json => {:success => true}
  end

  def failure
    return render :json => {:success => false, :errors => "The Username or Password is incorrect."}
  end
end