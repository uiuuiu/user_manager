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
  end
end
