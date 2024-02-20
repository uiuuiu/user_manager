# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Default roles
roles_hash = {
  "TeamAdmin" => {
    users: ["1", "2", "3"],
    teams: ["1", "2"],
    roles: ["1", "2", "3"]
  },
  "SubAdmin" => {
    users: ["1", "2", "3"],
    teams: ["1", "2"],
    roles: ["1"]
  },
  "User" => {
    users: ["1"],
    teams: ["1"],
    roles: ["1"]
  }
}

roles_hash.each do |role_name, permissions|
  Role.find_or_create_by!(
    name: role_name,
    description: "A role that allows a user to perform actions as a #{role_name}",
    permissions: permissions
  )
end

User.transaction do
  20.times do |index|
    user = User.new
    user.email = "test#{index}@example.com"
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.username = "#{user.first_name.downcase}_#{user.last_name.downcase}"
    user.password = "password"
    user.password_confirmation = "password"
    user.confirmed_at = Time.now
    user.save!(validate: false)
  end
end

users = User.all

Team.transaction do
  10.times do |index|
    owner = users.sample
    team = Team.create!(
      name: "Team #{index}",
      description: Faker::Lorem.sentence,
      owner: owner
    )
    TeamUser.create!(
      user: owner,
      team: team
    )
  end
end

teams = Team.all
TeamUser.transaction do
  teams.each do |team|
    total_users = [2, 3, 4].sample
    user_ids = users.without(team.owner).sample(total_users).pluck(:id)
    user_ids.each do |user_id|
      team_user = TeamUser.create!(
        user_id: user_id,
        team_id: team.id
      )

      TeamUserRole.create!(
        team_user: team_user,
        team_role: team.team_roles.sample
      )
    end
  end
end
