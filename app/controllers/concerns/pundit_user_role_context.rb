class PunditUserRoleContext
  attr_reader :object, :current_team, :role

  def initialize(user, current_team, role = nil)
    @object = user
    @current_team = current_team
    @role = role
  end
end
