class UsersController < AuthenticatedTeamController
  before_action :set_user, only: [:edit, :update]

  def index
    authorize :user, :index?
    User.preload_teams_associations_with_current_team_id(current_team.id) do
      @users = current_team.users.order(id: :asc).includes(:current_team_roles).decorate
      # To use class attribute when rendering the view
      render :index
    end
  end

  def edit
    authorize :user, :edit?
    User.preload_teams_associations_with_current_team_id(current_team.id) do
      @roles = current_team.roles
      # To use class attribute when rendering the view
      render :edit
    end
  end

  def update
    authorize :user, :update?
    User.preload_teams_associations_with_current_team_id(current_team.id) do
      service = Users::UpdateTeamRolesService.call(current_team, @user, permitted_params[:current_team_role_ids].compact_blank.map(&:to_i))
      # To use class attribute when rendering the view
      if service.success?
        redirect_to edit_user_path(@user), notice: "User roles updated"
      else
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    authorize :user, :destroy?
    user = current_team.users.find(params[:id])
    if user.id == current_team.owner_id || user.id == current_user.id
      redirect_to users_path, notice: "You can't remove yourself or the owner"
    elsif current_team.team_users.find_by(user_id: user.id).destroy
      redirect_to users_path, notice: "User removed from team"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def permitted_params
    params.require(:user).permit(current_team_role_ids: [])
  end

  def set_user
    @user = current_team.users.find(params[:id]).decorate
  end
end
