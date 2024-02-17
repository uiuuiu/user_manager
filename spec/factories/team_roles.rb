# This will guess the TeamRole class
FactoryBot.define do
  factory :default_team_role, class: "TeamRole" do
    team { Team.first || FactoryBot.create(:default_team) }
    role { Role.first || FactoryBot.create(:default_role) }
  end

  factory :team_role do
    team { Team.first || FactoryBot.create(:default_team) }
    role { Role.first || FactoryBot.create(:default_role) }
  end
end
