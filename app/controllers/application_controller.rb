class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
# for teh cancan
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
    I18n.locale = :ru
  end
  before_filter :set_locale

  def change_locale
    if current_user.nil?
      session[:locale] = params[:locale]
    else
      current_user.update!(:locale => params[:locale]) 
    end
    redirect_to :back
  end

  protected

  def set_locale
    session[:locale] ||= "ru"
    if current_user.nil?
      I18n.locale = session[:locale].to_sym
    else
      I18n.locale = current_user.locale.to_sym
    end
  end

  def configure_permitted_parameters

    #devise_parameter_sanitizer.for(:sign_up) << :phone
    #devise_parameter_sanitizer.for(:sign_up) << :owner_clubs
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:phone, :owner_clubs)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:phone, :owner_clubs, :email, :password, :password_confirmation, :current_password)}
  end

end
