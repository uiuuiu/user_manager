require "rails_helper"

RSpec.describe RolesController, type: :controller do
  describe "Common actions" do
    init_data
    login_user

    describe "GET index" do
      before { get :index }

      it "assigns @roles" do
        expect(assigns(:roles)).to be_decorated_with(Draper::CollectionDecorator)
        expect(assigns(:roles).object).to eq(team.roles.order(id: :asc))
      end

      it "renders the index template" do
        should render_template("index")
      end
    end

    describe "GET edit" do
      before { get :edit, params: {id: team.roles.first.id} }

      it "assigns @role" do
        expect(assigns(:role)).to be_decorated_with(RoleDecorator)
        expect(assigns(:role).object).to eq(team.roles.first)
        expect(assigns(:resources)).to eq(RoleResource.all)
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
    let(:user_role) { new_team_user_role.role }

    context "User has permission to read role" do
      before do
        User.current_team_id = team.id
        user_role.update!(permissions: {"roles" => ["1"]})
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
        before { post :create, params: {role: {name: "New role"}} }
        include_examples "unauthorized behaviors"
      end

      describe "GET edit" do
        before { get :edit, params: {id: user_role.id} }
        include_examples "unauthorized behaviors"
      end

      describe "PUT update" do
        before { put :update, params: {id: role.id, role: {name: "Updated Role"}} }
        include_examples "unauthorized behaviors"
      end

      describe "DELETE destroy" do
        before { delete :destroy, params: {id: role.id} }
        include_examples "unauthorized behaviors"
      end
    end

    context "User has permissions to read, write role" do
      before do
        User.current_team_id = team.id
        user_role.update!(permissions: {"roles" => ["1", "2"]})
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
        before { post :create, params: {role: {name: "New role"}} }

        it "redirects to roles path" do
          should redirect_to(edit_role_path(Role.last))
        end

        it "sets a flash notice" do
          expect(flash[:notice]).to eq("Role created successfully")
        end
      end

      describe "GET edit" do
        before { get :edit, params: {id: user_role.id} }

        it "renders the edit template" do
          should render_template("edit")
        end
      end

      describe "PUT update" do
        context "default role" do
          before { put :update, params: {id: user_role.id, role: {name: "Updated Role"}} }

          it "redirects to edit role path" do
            should redirect_to(root_path)
          end

          it "sets a flash notice" do
            expect(flash[:alert]).to eq("You are not authorized to perform this action.")
          end
        end

        context "custom role" do
          let!(:custom_role) { create(:role, name: "Custom Role", team: team, permissions: {"roles" => ["1", "2"]}) }
          let!(:custom_team_role) { create(:team_role, team: team, role: custom_role) }
          before { put :update, params: {id: custom_role.id, role: {name: "Updated Role"}} }

          it "updated the role name" do
            expect(custom_role.reload.name).to eq("Updated Role")
          end

          it "redirects to edit role path" do
            should redirect_to(edit_role_path(custom_role))
          end

          it "sets a flash notice" do
            expect(flash[:notice]).to eq("Role updated successfully")
          end
        end
      end

      describe "DELETE destroy" do
        before { delete :destroy, params: {id: user_role.id} }
        include_examples "unauthorized behaviors"
      end
    end
  end
end
