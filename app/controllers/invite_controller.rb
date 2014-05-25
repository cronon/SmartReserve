class InviteController < ApplicationController

  #post call from adminka
  def send_email
  	pass = SecureRandom.hex.to_s[0...8]
  	invite = params[:invite]
  	u = User.new(email: params[:email], phone: params[:phone],
  	 password: pass, name: params[:name]) 
  	puts "User = #{u}"
  	u.save!


  end

  #ссыль на сие будет в письме с инвайтом
  def sign_in
  end

end
