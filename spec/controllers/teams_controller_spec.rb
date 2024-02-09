require "rails_helper"

RSpec.describe TeamsController, type: :controller do
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
end
