require "rails_helper"

RSpec.describe UsersController, type: :controller do
  init_data
  login_user
  let!(:current_team) { user.teams.first }

  describe "GET index" do
    before { get :index }

    it "assigns @users" do
      expect(assigns(:users)).to be_decorated_with(Draper::CollectionDecorator)
      expect(assigns(:users).object).to eq(current_team.users)
    end

    it "renders the index template" do
      should render_template("index")
    end
  end

  describe "GET edit" do
    before { get :edit, params: {id: subject.current_user.id} }

    it "assigns @user" do
      expect(assigns(:user)).to be_decorated_with(UserDecorator)
      expect(assigns(:user).object).to eq(subject.current_user)
    end

    it "assigns @roles" do
      expect(assigns(:roles)).to eq(current_team.roles)
    end

    it "renders the edit template" do
      should render_template("edit")
    end
  end

  describe "PUT update" do
    let(:role) { FactoryBot.create(:default_role) }
    let(:team_role) { FactoryBot.create(:default_team_role, team: current_team, role: role) }
    let(:params) { {id: subject.current_user.id, user: {current_team_role_ids: [team_role.id]}} }

    before { put :update, params: params }

    it "redirects to edit user path" do
      should redirect_to(edit_user_path(subject.current_user))
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq("User roles updated")
    end
  end
end
