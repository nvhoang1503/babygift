require "spec_helper"

describe RedeemsController do
  describe "routing" do

    it "routes to #index" do
      get("/redeems").should route_to("redeems#index")
    end

    it "routes to #new" do
      get("/redeems/new").should route_to("redeems#new")
    end

    it "routes to #show" do
      get("/redeems/1").should route_to("redeems#show", :id => "1")
    end

    it "routes to #edit" do
      get("/redeems/1/edit").should route_to("redeems#edit", :id => "1")
    end

    it "routes to #create" do
      post("/redeems").should route_to("redeems#create")
    end

    it "routes to #update" do
      put("/redeems/1").should route_to("redeems#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/redeems/1").should route_to("redeems#destroy", :id => "1")
    end

  end
end
