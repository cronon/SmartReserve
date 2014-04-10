require "spec_helper"

describe ControllersController do
  describe "routing" do

    it "routes to #index" do
      get("/controllers").should route_to("controllers#index")
    end

    it "routes to #new" do
      get("/controllers/new").should route_to("controllers#new")
    end

    it "routes to #show" do
      get("/controllers/1").should route_to("controllers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/controllers/1/edit").should route_to("controllers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/controllers").should route_to("controllers#create")
    end

    it "routes to #update" do
      put("/controllers/1").should route_to("controllers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/controllers/1").should route_to("controllers#destroy", :id => "1")
    end

  end
end
