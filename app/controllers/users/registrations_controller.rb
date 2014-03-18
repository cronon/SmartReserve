class Users::RegistrationsController < Devise::RegistrationsController
  def new
    email = params[:email]
    puts params
    super do |resource|
      @resource = User.new :email => params[:email]
      @devise_mapping ||= Devise.mappings[:user]
    end
  end
end