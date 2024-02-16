class RolesController < AuthenticatedTeamController
  before_action :set_role, only: [:edit, :update]

  def index
    @roles = current_team.roles.order(id: :asc).decorate
  end

  def edit
    @resources = RoleResource.all
  end

  def update
    @role.update(permitted_params)
    redirect_to edit_role_path(@role)
  end

  private

  def permitted_params
    params.require(:role).permit(:name, :description, permissions: {})
  end

  def set_role
    @role = current_team.roles.find(params[:id]).decorate
  end
end
