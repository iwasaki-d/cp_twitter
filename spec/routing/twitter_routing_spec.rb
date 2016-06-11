require "rails_helper"

RSpec.describe TwitterController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/twitter").to route_to("twitter#index")
    end

    it "routes to #new" do
      expect(:get => "/twitter/new").to route_to("twitter#new")
    end

    it "routes to #show" do
      expect(:get => "/twitter/1").to route_to("twitter#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/twitter/1/edit").to route_to("twitter#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/twitter").to route_to("twitter#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/twitter/1").to route_to("twitter#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/twitter/1").to route_to("twitter#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/twitter/1").to route_to("twitter#destroy", :id => "1")
    end

  end
end
