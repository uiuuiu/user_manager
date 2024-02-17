# This will guess the Role class
FactoryBot.define do
  factory :default_role, class: "Role" do
    name { "Admin" }
    description { "test" }
  end

  factory :role do
    name { "Admin" }
    description { "test" }
    team { FactoryBot.create(:default_team) }
    permissions {
      {teams: ["1", "2", "3"]}
    }

    factory :role_team_admin do
      name { "TeamAdmin" }
      permissions {
        {
          users: ["1", "2", "3"],
          teams: ["1", "2", "3"],
          roles: ["1", "2", "3"]
        }
      }
    end

    factory :role_sub_admin do
      name { "SubAdmin" }
      permissions {
        {
          users: ["1", "2", "3"],
          teams: ["1", "2"]
        }
      }
    end

    factory :role_user do
      name { "User" }
      permissions {
        {
          users: ["1"],
          teams: ["1"],
          roles: ["1"]
        }
      }
    end
  end
end
