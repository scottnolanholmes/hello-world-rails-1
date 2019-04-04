require "rails_helper"

RSpec.describe "HelloWorlds", type: :request do
  describe "View HelloWorlds" do
    let(:hw) { create(:hello_world) }

    it "index" do
      get hello_worlds_path
      expect(response).to render_template(:index)
    end

    it "show" do
      get "/hello_worlds/#{hw.id}"
      expect(response).to render_template(:show)
    end

    it "not found" do
      expect { get "/hoge" }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "Creates HelloWorlds" do
    it "success" do
      get new_hello_world_path
      expect(response).to render_template(:new)

      post "/hello_worlds", params: { hello_world: { country: "CN", hello: "test", priority: (HelloWorld.all.size + 1) } }

      expect(response).to redirect_to(assigns(:hello_world))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).not_to match(/error_explanation/im)
    end

    it "failed" do
      get new_hello_world_path
      post "/hello_worlds", params: { hello_world: { country: "", hello: "" } }

      expect(response).to render_template(:new)
      expect(response.body).to match(/error_explanation/im)
    end
  end

  describe "Update HelloWorlds" do
    let(:hw) { create(:hello_world) }

    it "works! (now write some real specs)" do
      get edit_hello_world_path(hw)
      expect(response).to render_template(:edit)

      put "/hello_worlds/#{hw.id}", params: { hello_world: { country: "US", hello: "update test", priority: (HelloWorld.all.size + 1) } }

      expect(response).to redirect_to(assigns(:hello_world))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).not_to match(/error_explanation/im)
    end
  end

  describe "DELETE HelloWorlds" do
    let(:hw) { create(:hello_world) }
    it "delete " do
      delete "/hello_worlds/#{hw.id}"

      expect(response).to redirect_to(assigns(:hello_world))
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to match(/successfully destroyed/im)
    end
  end
end
