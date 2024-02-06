class TeamsController < ApplicationController

  def index
    @teams = Team.all.includes(:users).decorate
  end
end
