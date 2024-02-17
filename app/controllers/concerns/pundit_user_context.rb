class PunditUserContext
  attr_reader :object, :current_team

  def initialize(user, current_team)
    @object = user
    @current_team = current_team
  end
end
