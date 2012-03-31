require "spec_helper"

describe WorkersController do
  describe "routing" do

    it "routes to #index" do
      get("/workers").should route_to("workers#index")
    end

    it "routes to #show" do
      get("/workers/1").should route_to("workers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/workers/1/edit").should route_to("workers#edit", :id => "1")
    end

    it "routes to #update" do
      put("/workers/1").should route_to("workers#update", :id => "1")
    end
  end
end
