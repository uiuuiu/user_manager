require "rails_helper"

RSpec.describe TeamsController, type: :controller do
  init_data
  login_user

  describe "GET index" do
    before { get :index }

    it "assigns @teams" do
      expect(assigns(:teams)).to be_decorated_with(Draper::CollectionDecorator)
      expect(assigns(:teams).object).to eq(Team.all)
    end

    it "renders the index template" do
      should render_template("index")
    end
  end

  describe "GET edit" do
    before { get :edit, params: {id: Team.first.id} }

    it "assigns @team" do
      expect(assigns(:team)).to be_decorated_with(TeamDecorator)
      expect(assigns(:team).object).to eq(Team.first)
    end

    it "assigns @users" do
      expect(assigns(:users)).to be_decorated_with(Draper::CollectionDecorator)
      expect(assigns(:users).object).to eq(User.all)
    end

    it "renders the edit template" do
      should render_template("edit")
    end
  end
end
