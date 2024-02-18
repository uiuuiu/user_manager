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

  def login_new_user
    # Before each, login the new user and select the current team
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in new_user
      # set current_team
      @request.env["rack.session"]["current_team_id"] = user.teams.first.id
    end
  end

  def init_data_for_authorization
    # Before each test, create user and related data
    let!(:user) { FactoryBot.create(:default_user) }
    let!(:team) { FactoryBot.create(:default_team, owner: user) }
    let!(:role) { FactoryBot.create(:default_role) }
    let!(:team_user) { FactoryBot.create(:default_team_user, user: user, team: team) }
    let!(:team_role) { FactoryBot.create(:default_team_role, team: team, role: role) }
    let!(:new_user) { FactoryBot.create(:user) }
    let!(:new_team_user) { FactoryBot.create(:team_user, user: new_user, team: team) }
    let!(:new_team_user_role) { FactoryBot.create(:team_user_role, team_user: new_team_user, team_role: team_role) }
  end
end
