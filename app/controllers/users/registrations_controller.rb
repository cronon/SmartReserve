class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @resource = User.new(:email => params[:email], :phone=>'+375')
    puts @resource
    super
    # super do |resource|
    #   puts params
    #   puts resource
    #   puts 'sdfsd!!!!!!!!!!############'+(1/0).to_s
    #   resource = User.new :email => params[:email]
    #   #devise_mapping ||= Devise.mappings[:user]
    # end
  end
end