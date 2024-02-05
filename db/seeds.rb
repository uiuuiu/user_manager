# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.transaction do
  20.times do |index|
    user = User.new
    user.email = "test#{index}@example.com"
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.password = "password"
    user.password_confirmation = "password"
    user.save!
  end
end

Team.transaction do
  10.times do |index|
    Team.create!(
      name: "Team #{index}",
      description: Faker::Lorem.sentence
    )
  end
end

TeamUser.transaction do
  20.times do |index|
    TeamUser.create!(
      user: User.find(index + 1),
      team: Team.find((index / 2) + 1)
    )
  end
end

# Default roles
["TeamAdmin", "User"].each do |role_name|
  Role.find_or_create_by!(
    name: role_name,
    description: "A role that allows a user to perform actions as a #{role_name}",
    permissions: {}
  )
end

# Team 1 roles
Role.find_or_create_by!(
  team: Team.first,
  name: "SubAdmin",
  description: "A role that allows a user to perform actions as a Sub Admin",
  permissions: {}
)

Role.all.each do |role|
  TeamRole.find_or_create_by!(
    team: Team.first,
    role: role
  )
end
team = Team.first
team.team_users.each do |team_user|
  TeamUserRole.find_or_create_by!(
    team_user: team_user,
    team_role: team.team_roles.sample
  )
end
