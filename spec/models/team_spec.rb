require "rails_helper"

RSpec.describe Team, type: :model do
  describe "Validations" do
    # To avoid validate_uniqueness_of works by matching a new record against an
    # existing record. If there is no existing record, it will create one
    # using the record you provide.
    subject { FactoryBot.build(:default_team) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should_not validate_presence_of(:description) }
  end

  describe "Associations" do
    it { should belong_to(:owner).class_name("User") }
    it { should have_many(:team_users).dependent(:destroy) }
    it { should have_many(:users).through(:team_users) }
    it { should have_many(:team_roles).dependent(:destroy) }
    it { should have_many(:roles).through(:team_roles) }
    it { should have_many(:own_roles).class_name("Role").with_foreign_key("team_id").dependent(:destroy) }
    it { should have_many(:team_user_roles).through(:team_users) }
    it { should have_many(:admins).through(:team_users).source(:user).conditions("team_users.role = 'TeamAdmin'") }
    it { should have_many(:sub_admins).through(:team_users).source(:user).conditions("team_users.role = 'SubAdmin'") }
  end
end
