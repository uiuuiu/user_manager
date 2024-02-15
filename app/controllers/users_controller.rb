class UsersController < ApplicationController
  before_action :set_user, only: [:edit]

  def index
    @users = current_user.users_from_teams.order(id: :asc).includes(:teams).decorate
  end

  def edit
    @teams = current_user.teams.decorate
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id]).decorate
  end
end
