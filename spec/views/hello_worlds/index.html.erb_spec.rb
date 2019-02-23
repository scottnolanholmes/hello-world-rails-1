require 'rails_helper'

RSpec.describe "hello_worlds/index", type: :view do
  before(:each) do
    assign(:hello_worlds, [
      HelloWorld.create!(),
      HelloWorld.create!()
    ])
  end

  it "renders a list of hello_worlds" do
    render
  end
end
