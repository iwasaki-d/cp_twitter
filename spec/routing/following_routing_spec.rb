require "rails_helper"

RSpec.describe FollowingController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/following").to route_to("following#index")
    end

    it "routes to #new" do
      expect(:get => "/following/new").to route_to("following#new")
    end

    it "routes to #show" do
      expect(:get => "/following/1").to route_to("following#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/following/1/edit").to route_to("following#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/following").to route_to("following#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/following/1").to route_to("following#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/following/1").to route_to("following#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/following/1").to route_to("following#destroy", :id => "1")
    end

  end
end
