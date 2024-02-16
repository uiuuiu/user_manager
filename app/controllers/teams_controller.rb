class TeamsController < AuthenticatedTeamController
  before_action :set_team, only: [:edit]

  def index
    @teams = current_user.owned_teams.includes(:users).decorate
  end

  def edit
    @users = User.all.decorate
  end

  private

  def set_team
    @team = Team.find(params[:id]).decorate
  end
end
