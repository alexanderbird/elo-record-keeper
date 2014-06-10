require "spec_helper"

describe GametypesController do
  describe "routing" do

    it "routes to #index" do
      get("/gametypes").should route_to("gametypes#index")
    end

    it "routes to #new" do
      get("/gametypes/new").should route_to("gametypes#new")
    end

    it "routes to #show" do
      get("/gametypes/1").should route_to("gametypes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/gametypes/1/edit").should route_to("gametypes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/gametypes").should route_to("gametypes#create")
    end

    it "routes to #update" do
      put("/gametypes/1").should route_to("gametypes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/gametypes/1").should route_to("gametypes#destroy", :id => "1")
    end

  end
end
