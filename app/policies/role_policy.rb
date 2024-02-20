class RolePolicy < ApplicationPolicy
  attr_reader :user, :team, :role_resource, :role

  RESOURCE = "roles".freeze

  def initialize(user, _record)
    @user = user.object
    @team = user.current_team
    @role = user.role
    @role_resource = RoleResource.new(self.class::RESOURCE)
  end

  def update?
    return false unless role&.team_id
    on_current_team { owned_team? || user.current_team_roles.any? { |role| @role_resource.write?(role) } }
  end

  def destroy?
    return false unless role&.team_id
    on_current_team { owned_team? || user.current_team_roles.any? { |role| @role_resource.delete?(role) } }
  end
end
