require "rails_helper"

RSpec.describe TeamUserRole, type: :model do
  describe "Associations" do
    it { should belong_to(:team_user) }
    it { should belong_to(:team_role) }
    it { should have_one(:role).through(:team_role) }
  end
end
