# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :team, :role_resource

  def initialize(user, _record)
    @user = user.object
    @team = user.current_team
    @role_resource = RoleResource.new(self.class::RESOURCE)
  end

  def index?
    on_current_team { owned_team? || user.current_team_roles.any? { |role| @role_resource.read?(role) } }
  end

  def show?
    on_current_team { owned_team? || user.current_team_roles.any? { |role| @role_resource.read?(role) } }
  end

  def new?
    on_current_team { owned_team? || user.current_team_roles.any? { |role| @role_resource.write?(role) } }
  end

  def edit?
    on_current_team { owned_team? || user.current_team_roles.any? { |role| @role_resource.write?(role) } }
  end

  def destroy?
    on_current_team { owned_team? || user.current_team_roles.any? { |role| @role_resource.delete?(role) } }
  end

  def create?
    on_current_team { owned_team? || user.current_team_roles.any? { |role| @role_resource.write?(role) } }
  end

  def update?
    on_current_team { owned_team? || user.current_team_roles.any? { |role| @role_resource.write?(role) } }
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end

  private

  def owned_team?
    user.owned_teams.exists?(team.id)
  end

  def on_current_team
    User.preload_teams_associations_with_current_team_id(team.id) do
      yield
    end
  end
end
