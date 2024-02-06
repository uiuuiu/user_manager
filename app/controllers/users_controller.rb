class UsersController < ApplicationController

  def index
    @users = User.all.includes(:teams).decorate
  end
end
