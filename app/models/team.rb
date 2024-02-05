class Team < ApplicationRecord
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_many :team_roles, dependent: :destroy
  has_many :roles, through: :team_roles
  has_many :own_roles, class_name: "Role", foreign_key: "team_id", dependent: :destroy
end
