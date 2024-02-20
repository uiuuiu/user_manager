class DashboardController < AuthenticatedTeamController
  before_action :authenticate_user!
  skip_before_action :authenticate_team!

  def index
    @owners = User.owners.decorate
  end
end
