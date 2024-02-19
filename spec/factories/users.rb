# This will guess the User class
FactoryBot.define do
  factory :default_user, class: "User" do
    first_name { "Jimmy" }
    last_name { "Pham" }
    email { "dy.test1@yopmail.com" }
    username { "jimmy" }
    password { "abc123@" }
    password_confirmation { "abc123@" }
    confirmed_at { Time.now }
  end

  factory :user do
    first_name { "New user" }
    last_name { "001" }
    email { "dy.test2@yopmail.com" }
    username { "jimmy2" }
    password { "abc123@" }
    password_confirmation { "abc123@" }
    confirmed_at { Time.now }
  end
end
