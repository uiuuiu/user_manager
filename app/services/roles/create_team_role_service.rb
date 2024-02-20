class Roles::CreateTeamRoleService
  prepend SimpleCommand

  def initialize(team, permitted_params)
    @team = team
    @permitted_params = permitted_params
  end

  def call
    Role.transaction do
      role = team.own_roles.create!(permitted_params)
      TeamRole.create!(team: team, role: role)
      role
    end
  end

  private

  attr_accessor :team, :permitted_params

  def add_member(user_id)
    TeamUser.create(user_id: user_id, team_id: team.id)
  end

  def delete_member(user_id)
    TeamUser.find_by(user_id: user_id, team_id: team.id).destroy
  end
end
