class ProfileController < AuthenticatedTeamController
  def index
    @profile = current_user.decorate
  end

  def update
    current_user.assign_attributes(permit_params)
    current_user.is_profile_update = true
    if current_user.save
      redirect_to profile_index_path, notice: "Profile updated successfully"
    else
      redirect_back fallback_location: profile_index_path, flash: {error: current_user.errors.full_messages.join("<br>")}
    end
  end

  private

  def permit_params
    params.require(:user).permit(:first_name, :last_name, :avatar)
  end
end
