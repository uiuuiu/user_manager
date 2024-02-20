class TeamsController < AuthenticatedTeamController
  before_action :set_team, only: [:edit, :update, :destroy]

  def index
    authorize :team, :index?
    @teams = current_user.teams.includes(:users).decorate
  end

  def new
    authorize :team, :create?
    @team = current_user.owned_teams.new
    @users = User.all.decorate
  end

  def create
    authorize :team, :create?
    @team = current_user.owned_teams.new(permit_params)
    params[:team][:user_ids].reject(&:empty?).each { |id| @team.team_users << @team.team_users.new(user_id: id) } if params[:team][:user_ids].present?
    if @team.save!
      redirect_to edit_team_path(@team), notice: "Team created successfully"
    else
      redirect_back fallback_location: new_team_path, flash: {error: @team.errors.full_messages.join("<br>")}
    end
  end

  def update
    authorize :team, :update?
    Team.transaction do
      if @team.update(permit_params)
        service = Teams::UpdateMembersService.call(@team, params[:team][:user_ids] || [])
        if service.success?
          redirect_to edit_team_path(@team), notice: "Team updated successfully"
        else
          redirect_back fallback_location: edit_team_path(@team), flash: {error: service.errors.join("<br>")}
        end
      else
        redirect_back fallback_location: edit_team_path(@team), flash: {error: @team.errors.full_messages.join("<br>")}
      end
    end
  end

  def edit
    authorize :team, :edit?
    @users = User.all.decorate
  end

  def destroy
    authorize :team, :destroy?
    if @team.destroy
      redirect_to teams_path, notice: "Team deleted successfully"
    else
      redirect_back fallback_location: edit_team_path(@team), flash: {error: @team.errors.full_messages.join("<br>")}
    end
  end

  private

  def set_team
    @team = Team.find(params[:id]).decorate
  end

  def permit_params
    params.require(:team).permit(:name, :description)
  end
end
