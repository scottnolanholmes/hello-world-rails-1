require 'rails_helper'

RSpec.describe "hello_worlds/show", type: :view do
  before(:each) do
    @hello_world = assign(:hello_world, HelloWorld.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
