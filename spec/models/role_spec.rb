require "rails_helper"

RSpec.describe Role, type: :model do
  describe "Associations" do
    it { should have_many(:team_roles).dependent(:destroy) }
    it { should belong_to(:team).optional }
  end
end
