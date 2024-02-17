require "rails_helper"

describe TeamPolicy do
  let(:user) { create(:default_user) }
  let(:team) { create(:default_team, owner: user) }
  let(:team_user) { create(:default_team_user, user: user, team: team) }
  let(:pundit_user_context) { PunditUserContext.new(user, team) }
  subject { described_class.new(pundit_user_context, "teams") }

  before do
    User.current_team_id = team.id
  end

  describe "resource" do
    context "with correct resource" do
      it "returns the resource" do
        expect(subject.role_resource).to be_a RoleResource
      end
    end

    context "with wrong resource" do
      it "raises an exception" do
        expect { described_class.new(pundit_user_context, "Resource not found") }.to raise_error Pundit::NotDefinedError
      end
    end
  end

  context "with owner" do
    it { is_expected.to permit_all_actions }
  end

  context "with TeamAdmin" do
    let(:new_user) { create(:user) }
    let(:team_user) { create(:team_user, user: new_user, team: team) }
    let(:role) { create(:role_team_admin, team: team) }
    let(:team_role) { create(:team_role, team: team, role: role) }
    let!(:team_user_role) { create(:team_user_role, team_user: team_user, team_role: team_role) }
    let(:pundit_new_user_context) { PunditUserContext.new(new_user, team) }

    subject { described_class.new(pundit_new_user_context, "teams") }

    it { is_expected.to permit_all_actions }
  end

  context "with SubAdmin" do
    let(:new_user) { create(:user) }
    let(:team_user) { create(:team_user, user: new_user, team: team) }
    let(:role) { create(:role_sub_admin, team: team) }
    let(:team_role) { create(:team_role, team: team, role: role) }
    let!(:team_user_role) { create(:team_user_role, team_user: team_user, team_role: team_role) }
    let(:pundit_new_user_context) { PunditUserContext.new(new_user, team) }

    subject { described_class.new(pundit_new_user_context, "teams") }

    it { is_expected.to permit_actions(%i[index show new edit update]) }
    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context "with User" do
    let(:new_user) { create(:user) }
    let(:team_user) { create(:team_user, user: new_user, team: team) }
    let(:role) { create(:role_user, team: team) }
    let(:team_role) { create(:team_role, team: team, role: role) }
    let!(:team_user_role) { create(:team_user_role, team_user: team_user, team_role: team_role) }
    let(:pundit_new_user_context) { PunditUserContext.new(new_user, team) }

    subject { described_class.new(pundit_new_user_context, "teams") }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new edit update destroy]) }
  end
end
