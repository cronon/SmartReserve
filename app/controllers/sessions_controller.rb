# encoding: UTF-8
class SessionsController < Devise::SessionsController
  skip_authorize_resource :only => [:create,:sign_in_and_redirect,:failure,:sign_in_owner]

  def sign_in_owner
    resource = User.find_by_email(params[:user][:email])
    if resource.encrypted_password.blank?      
      redirect_to(
        new_user_session_path, 
        :notice => 'Invalid Email Address or Password. Password is case sensitive.'
        ) and return
    end  
    bcrypt   = BCrypt::Password.new(resource.encrypted_password)
    password = BCrypt::Engine.hash_secret("#{params[:user][:password]}#{resource.class.pepper}", bcrypt.salt)
    valid = Devise.secure_compare(password, resource.encrypted_password)
    if valid
      sign_in(resource_name, resource)
      redirect_to new_club_url and return
    else
      redirect_to(
        new_user_session_path, 
        :notice => 'Invalid Email Address or Password. Password is case sensitive.'
        ) and return    
    end
  end

  def create
    if request.xhr?
      resource = warden.authenticate(:scope => resource_name, :recall => '#{controller_path}#failure')
      if resource
        sign_in_and_redirect(resource_name, resource)
      else
        failure
      end
    elsif params[:owner]
      resource = warden.authenticate(:scope => resource_name, :recall => '#{controller_path}#failure')
      if resource 
        sign_in_owner(resource_name, resource)
      else
        failure
      end
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
    flash[:alert] = t('.wrong_login_or_pass')
    return render 'remote_content/devise_errors'
  end
  protected 

    # def sign_in_owner(resource_or_scope, resource=nil)
    #   scope = Devise::Mapping.find_scope!(resource_or_scope)
    #   resource ||= resource_or_scope
    #   sign_in(scope, resource) unless warden.user(scope) == resource
    #   redirect_to new_club_url and return
    # end
end