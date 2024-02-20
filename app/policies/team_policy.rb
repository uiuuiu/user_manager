class TeamPolicy < ApplicationPolicy
  attr_reader :user, :team, :role_resource

  RESOURCE = "teams".freeze

  def new?
    true
  end

  def create?
    true
  end
end
