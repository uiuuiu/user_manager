require "rails_helper"

RSpec.describe TeamUser, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
    it { should have_many(:team_user_roles).dependent(:destroy) }
  end
end
