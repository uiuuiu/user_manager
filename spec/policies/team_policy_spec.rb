require 'rails_helper'

describe TeamPolicy do
  context 'with owner' do
    it { is_expected.to permit_all_actions }
  end

  context 'with TeamAdmin' do
    # let(:user) { create(:default_user) }
    # let(:team) { create(:default_team, owner: user) }
    # let(:team_user) { create(:default_team_user, user: user, team: team) }

    # subject { described_class.new(team_user, team) }

    it { is_expected.to permit_actions(%i[index update destroy]) }
  end

  context 'with SubAdmin' do
    # let(:user) { create(:default_user) }
    # let(:team) { create(:default_team, owner: user) }
    # let(:team_user) { create(:default_team_user, user: user, team: team) }

    # subject { described_class.new(team_user, team) }

    it { is_expected.to permit_actions(%i[show update]) }
    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context 'with User' do
    # let(:user) { create(:default_user) }
    # let(:team) { create(:default_team, owner: user) }
    # let(:team_user) { create(:default_team_user, user: user, team: team) }

    # subject { described_class.new(team_user, team) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions(%i[index update destroy]) }
  end
end
