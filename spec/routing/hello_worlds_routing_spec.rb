require "rails_helper"

RSpec.describe HelloWorldsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/hello_worlds").to route_to("hello_worlds#index")
    end

    it "routes to #new" do
      expect(:get => "/hello_worlds/new").to route_to("hello_worlds#new")
    end

    it "routes to #show" do
      expect(:get => "/hello_worlds/1").to route_to("hello_worlds#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hello_worlds/1/edit").to route_to("hello_worlds#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/hello_worlds").to route_to("hello_worlds#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/hello_worlds/1").to route_to("hello_worlds#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/hello_worlds/1").to route_to("hello_worlds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hello_worlds/1").to route_to("hello_worlds#destroy", :id => "1")
    end
  end
end
