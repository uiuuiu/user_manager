class Users::UpdateTeamRolesService
  prepend SimpleCommand

  def initialize(team, user, role_ids)
    @team = team
    @team_user_id = @team.team_users.find_by(user_id: user.id).id
    @user = user
    @role_ids = role_ids
  end

  def call
    current_role_ids = user.current_team_roles.pluck(:id)
    deleted_role_ids = current_role_ids - role_ids
    added_role_ids = role_ids - current_role_ids
    TeamUserRole.transaction do
      deleted_role_ids.each { |role_id| delete_role(role_id) }
      added_role_ids.each { |role_id| add_role(role_id) }
    end
  end

  private

  attr_accessor :user, :team, :role_ids, :team_user_id

  def add_role(role_id)
    TeamUserRole.create(team_user_id: team_user_id, team_role_id: role_id)
  end

  def delete_role(role_id)
    TeamUserRole.find_by(team_user_id: team_user_id, team_role_id: role_id).destroy
  end
end
