require "rails_helper"

RSpec.describe TeamsController, type: :controller do
  describe "Common actions" do
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

  describe "Authorization" do
    shared_examples "unauthorized behaviors" do
      it "redirects to root" do
        should redirect_to(root_path)
      end

      it "sets a flash alert" do
        expect(flash[:alert]).to eq("You are not authorized to perform this action.")
      end
    end

    init_data_for_authorization
    login_new_user

    context "User has permission to read team" do
      before do
        User.current_team_id = team.id
        new_team_user_role.role.update!(permissions: {"teams" => ["1"]})
      end

      after do
        User.current_team_id = nil
      end

      describe "GET index" do
        before { get :index }

        it "renders the index template" do
          should render_template("index")
        end
      end

      describe "GET new" do
        before { get :new }
        include_examples "unauthorized behaviors"
      end

      describe "POST create" do
        before { post :create, params: {team: {name: "New Team"}} }
        include_examples "unauthorized behaviors"
      end

      describe "GET edit" do
        before { get :edit, params: {id: team.id} }
        include_examples "unauthorized behaviors"
      end

      describe "PUT update" do
        before { put :update, params: {id: team.id, team: {name: "Updated Team"}} }
        include_examples "unauthorized behaviors"
      end

      describe "DELETE destroy" do
        before { delete :destroy, params: {id: team.id} }
        include_examples "unauthorized behaviors"
      end
    end

    context "User has permissions to read, write team" do
      before do
        User.current_team_id = team.id
        new_team_user_role.role.update!(permissions: {"teams" => ["1", "2"]})
      end

      after do
        User.current_team_id = nil
      end

      describe "GET index" do
        before { get :index }

        it "renders the index template" do
          should render_template("index")
        end
      end

      describe "GET new" do
        before { get :new }

        it "renders the new template" do
          should render_template("new")
        end
      end

      describe "POST create" do
        before { post :create, params: {team: {name: "New Team"}} }

        it "redirects to teams path" do
          should redirect_to(edit_team_path(Team.last))
        end

        it "sets a flash notice" do
          expect(flash[:notice]).to eq("Team created successfully")
        end
      end

      describe "GET edit" do
        before { get :edit, params: {id: team.id} }

        it "renders the edit template" do
          should render_template("edit")
        end
      end

      describe "PUT update" do
        before { put :update, params: {id: team.id, team: {name: "Updated Team"}} }

        it "redirects to edit team path" do
          should redirect_to(edit_team_path(team))
        end

        it "sets a flash notice" do
          expect(flash[:notice]).to eq("Team updated successfully")
        end
      end

      describe "DELETE destroy" do
        before { delete :destroy, params: {id: team.id} }
        include_examples "unauthorized behaviors"
      end
    end
  end
end
