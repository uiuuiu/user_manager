require "rails_helper"

RSpec.describe UsersController, type: :controller do
  login_user

  describe "GET index" do
    before { get :index }

    it "assigns @users" do
      expect(assigns(:users)).to be_decorated_with(Draper::CollectionDecorator)
      expect(assigns(:users).object).to eq(User.all)
    end

    it "renders the index template" do
      should render_template("index")
    end
  end
end
