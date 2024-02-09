# This will guess the User class
FactoryBot.define do
  factory :default_user, class: "User" do
    first_name { "Jimmy" }
    last_name { "Pham" }
    email { "dy.test1@yopmail.com" }
    username { "jimmy" }
    password { "abc123@" }
    password_confirmation { "abc123@" }
  end
end
