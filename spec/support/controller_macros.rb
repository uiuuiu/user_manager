module ControllerMacros
  def login_user
    # Before each, login the user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in User.first
    end
  end

  def init_data
    # Before each test, create user and related data
    before(:each) do
      @user = FactoryBot.create(:default_user)
      @team = FactoryBot.create(:default_team, owner: @user)
      @role = FactoryBot.create(:default_role)
      @team_user = FactoryBot.create(:default_team_user, user: @user, team: @team)
    end
  end
end
