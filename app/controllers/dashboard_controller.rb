class DashboardController < AuthenticatedTeamController
  before_action :authenticate_user!
  skip_before_action :authenticate_team!

  def index
  end
end
