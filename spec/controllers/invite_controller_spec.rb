require 'spec_helper'

describe InviteController do

  describe "GET 'send_email'" do
    it "returns http success" do
      get 'send_email'
      response.should be_success
    end
  end

  describe "GET 'sign_in'" do
    it "returns http success" do
      get 'sign_in'
      response.should be_success
    end
  end

end
