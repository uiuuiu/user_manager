class Team < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_many :team_roles, dependent: :destroy
  has_many :roles, through: :team_roles
  has_many :own_roles, class_name: "Role", foreign_key: "team_id", dependent: :destroy
  has_many :team_user_roles, through: :team_users
  has_many :admins, -> { where("team_users.role = ?", "TeamAdmin") }, through: :team_users, source: :user
  has_many :sub_admins, -> { where("team_users.role = ?", "SubAdmin") }, through: :team_users, source: :user

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 50}

  after_create :create_default_team_roles

  private

  def create_default_team_roles
    TeamRole.transaction do
      Role.where(team_id: nil).each do |role|
        team_roles.create!(role: role)
      end
    end
  end
end
