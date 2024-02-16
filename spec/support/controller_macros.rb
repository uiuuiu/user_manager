module ControllerMacros
  def login_user
    # Before each, login the user and select the current team
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      # set current_team
      @request.env["rack.session"]["current_team_id"] = user.teams.first.id
    end
  end

  def init_data
    # Before each test, create user and related data
    let!(:user) { FactoryBot.create(:default_user) }
    let!(:team) { FactoryBot.create(:default_team, owner: user) }
    let!(:role) { FactoryBot.create(:default_role) }
    let!(:team_user) { FactoryBot.create(:default_team_user, user: user, team: team) }
    let!(:team_role) { FactoryBot.create(:default_team_role, team: team, role: role) }
  end
end
