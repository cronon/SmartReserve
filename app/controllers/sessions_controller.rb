class SessionsController < Devise::SessionsController
  skip_authorize_resource :only => [:create,:sign_in_and_redirect,:failure]

  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message(:notice, :signed_in) if is_flashing_format?
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?
  #   puts request.xhr?
  #   if request.xhr?
  #     if resource.signed_in?
  #       flash[:notice] = "Created account, signed in."
  #       render :template => "remote_content/devise_success_sign_in.js.erb"
  #       flash.discard
  #     else
  #       flash[:alert] = @user.errors.full_messages.to_sentence
  #       render :template => "remote_content/devise_errors.js.erb"
  #       flash.discard
  #     end
  #   else  
  #     respond_with resource, location: after_sign_in_path_for(resource)
  #   end
  # end


  def create
    p request.xhr?
    if request.xhr?
      p 'sdfdsf'
      resource = warden.authenticate!(:scope => resource_name, :recall => '#{controller_path}#failure')
      sign_in_and_redirect(resource_name, resource)
    else
      super
    end
  end
 
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render 'remote_content/devise_success_sign_in'
  end
 
  def failure
    return render 'remote_content/devise_errors'
  end
end