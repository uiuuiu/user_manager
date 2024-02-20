require "rails_helper"

describe RolePolicy do
  let(:user) { create(:default_user) }
  let(:team) { create(:default_team, owner: user) }
  let(:team_user) { create(:default_team_user, user: user, team: team) }
  let(:role) { create(:default_role) }
  let(:team_role) { create(:default_team_role, team: team, role: role) }
  let(:team_user_role) { create(:default_team_user_role, team_user: team_user, team_role: team_role) }
  let(:pundit_user_context) { PunditUserRoleContext.new(user, team, role) }
  subject { described_class.new(pundit_user_context, "roles") }

  before do
    User.current_team_id = team.id
  end

  describe "resource" do
    context "with correct resource" do
      it "returns the resource" do
        expect(subject.role_resource).to be_a RoleResource
      end
    end
  end

  context "with owner" do
    context "default role" do
      it { is_expected.to permit_actions(%i[index show new create edit]) }
      it { is_expected.to forbid_actions(%i[update destroy]) }
    end

    context "custom role" do
      let(:role) { create(:role, team: team) }
      let(:team_role) { create(:custom_team_role, team: team, role: role) }
      let(:team_user_role) { create(:custom_team_user_role, team_user: team_user, team_role: team_role) }

      it { is_expected.to permit_actions(%i[index show new create edit update destroy]) }
    end
  end

  context "with TeamAdmin" do
    let(:new_user) { create(:user) }
    let(:team_user) { create(:team_user, user: new_user, team: team) }
    let(:role) { create(:role_team_admin, team: team) }
    let(:team_role) { create(:team_role, team: team, role: role) }
    let!(:team_user_role) { create(:team_user_role, team_user: team_user, team_role: team_role) }
    let(:pundit_new_user_context) { PunditUserRoleContext.new(new_user, team, role) }

    subject { described_class.new(pundit_new_user_context, "roles") }

    it { is_expected.to permit_all_actions }
  end

  context "with SubAdmin" do
    let(:new_user) { create(:user) }
    let(:team_user) { create(:team_user, user: new_user, team: team) }
    let(:role) { create(:role_sub_admin, team: team) }
    let(:team_role) { create(:team_role, team: team, role: role) }
    let!(:team_user_role) { create(:team_user_role, team_user: team_user, team_role: team_role) }
    let(:pundit_new_user_context) { PunditUserRoleContext.new(new_user, team, role) }

    subject { described_class.new(pundit_new_user_context, "roles") }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new edit update create destroy]) }
  end

  context "with User" do
    let(:new_user) { create(:user) }
    let(:team_user) { create(:team_user, user: new_user, team: team) }
    let(:role) { create(:role_user, team: team) }
    let(:team_role) { create(:team_role, team: team, role: role) }
    let!(:team_user_role) { create(:team_user_role, team_user: team_user, team_role: team_role) }
    let(:pundit_new_user_context) { PunditUserRoleContext.new(new_user, team) }

    subject { described_class.new(pundit_new_user_context, "roles") }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new edit update destroy]) }
  end
end
