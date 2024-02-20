class RolesController < AuthenticatedTeamController
  before_action :set_role, only: [:edit, :update, :destroy]

  def index
    authorize :role, :index?
    @roles = current_team.roles.order(id: :asc).decorate
  end

  def new
    authorize :role, :create?
    @role = current_team.own_roles.new(permissions: {})
    @resources = RoleResource.all
  end

  def create
    authorize :role, :create?
    service = Roles::CreateTeamRoleService.call(current_team, permitted_params)
    if service.success?
      redirect_to edit_role_path(service.result), notice: "Role created successfully"
    else
      flash[:error] = service.errors.full_messages.join(", ")
      redirect_back fallback_location: new_role_path, flash: flash
    end
  end

  def edit
    authorize :role, :edit?
    @resources = RoleResource.all
  end

  def update
    authorize :role, :update?
    if @role.update(permitted_params)
      redirect_to edit_role_path(@role), notice: "Role updated successfully"
    else
      flash[:error] = @role.errors.full_messages.join(", ")
      redirect_back fallback_location: edit_role_path(@role), flash: flash
    end
  end

  def destroy
    authorize :role, :destroy?
    @role.destroy
    redirect_to roles_path
  end

  private

  def permitted_params
    params.require(:role).permit(:name, :description, permissions: {})
  end

  def set_role
    @role = current_team.roles.find(params[:id]).decorate
  end

  def pundit_user
    PunditUserRoleContext.new(current_user, current_team, @role)
  end
end
