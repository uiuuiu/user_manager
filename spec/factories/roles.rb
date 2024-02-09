# This will guess the Role class
FactoryBot.define do
  factory :default_role, class: "Role" do
    name { "Admin" }
    description { "test" }
  end
end
