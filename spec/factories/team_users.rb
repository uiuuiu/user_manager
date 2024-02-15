FactoryBot.define do
  factory :default_team_user, class: "TeamUser" do
    user { User.first || FactoryBot.create(:default_user) }
    team { Team.first || FactoryBot.create(:default_team) }
  end
end
