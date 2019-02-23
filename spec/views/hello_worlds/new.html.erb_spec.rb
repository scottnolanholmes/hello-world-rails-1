require 'rails_helper'

RSpec.describe "hello_worlds/new", type: :view do
  before(:each) do
    assign(:hello_world, HelloWorld.new())
  end

  it "renders new hello_world form" do
    render

    assert_select "form[action=?][method=?]", hello_worlds_path, "post" do
    end
  end
end
