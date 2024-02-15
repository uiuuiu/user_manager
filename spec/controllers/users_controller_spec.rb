require "rails_helper"

RSpec.describe UsersController, type: :controller do
  init_data
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

  describe "GET edit" do
    before { get :edit, params: {id: subject.current_user.id} }

    it "assigns @user" do
      expect(assigns(:user)).to be_decorated_with(UserDecorator)
      expect(assigns(:user).object).to eq(subject.current_user)
    end

    it "assigns @teams" do
      expect(assigns(:teams)).to be_decorated_with(Draper::CollectionDecorator)
      expect(assigns(:teams).object).to eq(subject.current_user.teams)
    end

    it "renders the edit template" do
      should render_template("edit")
    end
  end
end
