# This will guess the TeamUserRole class
FactoryBot.define do
  factory :default_team_user_role, class: "TeamUserRole" do
    team_user { TeamUser.first || FactoryBot.create(:default_team_user) }
    team_role { TeamRole.first || FactoryBot.create(:default_team_role) }
  end

  factory :team_user_role do
    team_user { TeamUser.first || FactoryBot.create(:default_team_user) }
    team_role { TeamRole.first || FactoryBot.create(:default_team_role) }
  end
end
