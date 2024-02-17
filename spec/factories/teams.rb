# This will guess the Team class
FactoryBot.define do
  factory :default_team, class: "Team" do
    name { "Jimmy's Team" }
    description { "test" }
    owner { User.first || FactoryBot.create(:default_user) }
  end

  factory :team do
    name { "New Team" }
    description { "test" }
    owner { FactoryBot.create(:user) }
  end
end
