require 'rails_helper'

RSpec.describe "hello_worlds/edit", type: :view do
  before(:each) do
    @hello_world = assign(:hello_world, HelloWorld.create!())
  end

  it "renders the edit hello_world form" do
    render

    assert_select "form[action=?][method=?]", hello_world_path(@hello_world), "post" do
    end
  end
end
