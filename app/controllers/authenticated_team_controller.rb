class AuthenticatedTeamController < ApplicationController
  include Pundit
  before_action :authenticate_team!
  helper_method :current_team

  protected

  def authenticate_team!
    redirect_to root_path if current_team.blank?
  end

  def current_team
    @current_team ||= current_user.teams.find_by(id: session[:current_team_id])
  end

  def pundit_user
    PunditUserContext.new(current_user, current_team)
  end
end
