require "rails_helper"

RSpec.describe HelloWorld, type: :model do
  let(:country) {
    HelloWorld.all.reject {|hw| SETTING[:country].keys.include?(hw.country) }.first || "JP"
  }
  let(:priority) { HelloWorld.all.size + 1 }
  let(:hello) { "Test Hello World" }
  let(:hello_world) { build(:hello_world, country: country, priority: priority, hello: hello) }

  before(:each) { hello_world.save }

  context "Success to create" do
    let(:hello) { "Test Hello World 001" }
    it "Hello World created" do
      expect(hello_world.errors.details).to be_empty
      expect(hello_world.country).to eq(country)
      expect(hello_world.hello).to eq("Test Hello World 001")
      expect(hello_world.priority).to eq(priority)
    end
  end

  context "Failed to create" do
    let(:hello) { nil }
    it "hello is bulnk" do
      expect(hello_world.errors.details).not_to be_empty
      expect(hello_world.errors.details[:hello].first[:error]).to eq(:blank)
    end
  end

  context "Failed to create" do
    let(:country) { nil }
    it "country is not uniq" do
      expect(hello_world.errors.details).not_to be_empty
      expect(hello_world.errors.details[:country].first[:error]).to eq(:blank)
    end
  end

  context "Failed to create" do
    let(:country) { "TEST" }
    it "country is not uniq" do
      expect(hello_world.errors.details).not_to be_empty
      expect(hello_world.errors.details[:country].first[:error]).to eq(:inclusion)
    end
  end

  context "Failed to create" do
    let(:new_record) { create(:hello_world) }
    let(:country) { new_record.country }
    it "country is not uniq" do
      expect(hello_world.errors.details).not_to be_empty
      expect(hello_world.errors.details[:country].first[:error]).to eq(:taken)
    end
  end

  context "Failed to create" do
    let(:priority) { nil }
    it "priority is not uniq" do
      expect(hello_world.errors.details).not_to be_empty
      expect(hello_world.errors.details[:priority].first[:error]).to eq(:blank)
    end
  end

  context "Failed to create" do
    let(:priority) { 197 }
    it "priority is not uniq" do
      expect(hello_world.errors.details).not_to be_empty
      expect(hello_world.errors.details[:priority].first[:error]).to eq(:less_than_or_equal_to)
    end
  end

  context "Failed to create" do
    let(:priority) { "test" }
    it "priority is not uniq" do
      expect(hello_world.errors.details).not_to be_empty
      expect(hello_world.errors.details[:priority].first[:error]).to eq(:not_a_number)
    end
  end

  context "Failed to create" do
    let(:new_record) { create(:hello_world) }
    let(:priority) { new_record.priority }
    it "priority is not uniq" do
      expect(hello_world.errors.details).not_to be_empty
      expect(hello_world.errors.details[:priority].first[:error]).to eq(:taken)
    end
  end
end
