class Teams::UpdateMembersService
  prepend SimpleCommand

  def initialize(team, user_ids)
    @team = team
    @user_ids = user_ids
  end

  def call
    current_member_ids = team.team_users.pluck(:user_id)
    deleted_member_ids = current_member_ids - user_ids
    added_member_ids = user_ids - current_member_ids
    TeamUser.transaction do
      deleted_member_ids.each { |user_id| delete_member(user_id) }
      added_member_ids.each { |user_id| add_member(user_id) }
    end
  end

  private

  attr_accessor :team, :user_ids

  def add_member(user_id)
    TeamUser.create(user_id: user_id, team_id: team.id)
  end

  def delete_member(user_id)
    TeamUser.find_by(user_id: user_id, team_id: team.id).destroy
  end
end
