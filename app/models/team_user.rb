class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team

  has_many :team_user_roles, dependent: :destroy
end
