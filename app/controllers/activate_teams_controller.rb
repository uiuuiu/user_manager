class ActivateTeamsController < ApplicationController
  before_action :set_team, only: [:show]

  def show
    redirect_back fallback_location: root_path, notice: "Team activated"
  end

  private

  def set_team
    @team = current_user.teams.find(params[:id])
    session[:current_team_id] = @team.id
  end
end
