require "rails_helper"

RSpec.describe User, type: :model do
  describe "Validations" do
    # To avoid validate_uniqueness_of works by matching a new record against an
    # existing record. If there is no existing record, it will create one
    # using the record you provide.
    subject { FactoryBot.build(:default_user) }

    it { should validate_presence_of(:email) }
    it { should_not validate_presence_of(:username) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(20) }
    it { should validate_length_of(:first_name).is_at_least(3).is_at_most(20) }
    it { should validate_length_of(:last_name).is_at_least(3).is_at_most(20) }
    it { should validate_length_of(:email).is_at_least(3).is_at_most(50) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }
    it { should validate_confirmation_of(:password) }
    it { should allow_value("abc123@").for(:password) }
    it { should_not allow_value("abc12").for(:password) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

  describe "Associations" do
    it { should have_many(:team_users).dependent(:destroy) }
    it { should have_many(:teams).through(:team_users) }
    it { should have_one_attached(:avatar) }
    it { should have_many(:users_from_teams).through(:teams).source(:users) }
    it { should have_many(:owned_teams).class_name("Team").with_foreign_key("owner_id") }
    it { should have_many(:current_team_roles).through(:current_team_user_roles).source(:role) }
  end

  describe "Associations with class attributes" do
    before do
      User.current_user_team_ids = [1, 2, 3]
      User.current_team_id = 1
    end

    after do
      User.current_user_team_ids = nil  # Reset class attribute
      User.current_team_id = nil  # Reset class attribute
    end

    it { should have_many(:belongs_current_user_teams).through(:team_users).source(:team).conditions(id: User.current_user_team_ids) }
    it { should have_many(:current_team_user_roles).through(:team_users).source(:team_user_roles).conditions("team_users.team_id = #{User.current_team_id}") }
  end
end
