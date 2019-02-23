FactoryBot.define do
  factory :hello_world do
    country "JP"
    sequence(:hello) {|i| "Test Hello #{i}" }
    sequence(:priority) {|i| i }

    after :create do |c|
      c.update_column(:image, "icon-png")
    end
  end
end
