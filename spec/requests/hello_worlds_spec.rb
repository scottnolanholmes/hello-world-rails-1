require "rails_helper"

RSpec.describe "HelloWorlds", type: :request do
  describe "View HelloWorlds" do

    it "index" do

    end

    it "show" do

    end

    it "not found" do
      get :hoge
      expect(response).to raise_error(ActionController)
    end
  end

  describe "Creates HelloWorlds" do
    it "success" do
      get hello_worlds_path
      expect(response).to render_template(:new)

      post "/hello_worlds", params: { hello_world: { country: "JP", hello: "こんにちは世界", priority: 1 }}

      expect(response).to redirect_to(assigns(:hello_worlds))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("Hello world was successfully created.")
    end

    it "failed" do
      post "/hello_worlds", params: { hello_world: { country: "JP", hello: "こんにちは世界"}}

      expect(response).to redirect_to(assigns(:widget))
      follow_redirect!

      expect(response).to render_template(:new)
      expect(response.body).to include("blank")
    end
  end

  # describe "Update HelloWorlds" do
  #   it "works! (now write some real specs)" do
  #     get hello_worlds_path
  #     expect(response).to render_template(:new)
  #
  #     post "/widgets", params: { widget: { name: "My Widget" } }
  #
  #     expect(response).to redirect_to(assigns(:widget))
  #     follow_redirect!
  #
  #     expect(response).to render_template(:show)
  #     expect(response.body).to include("Widget was successfully created.")
  #   end
  # end
  #
  # describe "DELETE HelloWorlds" do
  #   it "delete " do
  #     get hello_worlds_path
  #     expect(response).to render_template(:new)
  #
  #     post "/widgets", params: { widget: { name: "My Widget" } }
  #
  #     expect(response).to redirect_to(assigns(:widget))
  #     follow_redirect!
  #
  #     expect(response).to render_template(:show)
  #     expect(response.body).to include("Widget was successfully created.")
  #   end
  # end
end
