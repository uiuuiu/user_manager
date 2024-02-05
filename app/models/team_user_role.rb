class TeamUserRole < ApplicationRecord
  belongs_to :team_user
  belongs_to :team_role
  has_one :role, through: :team_role
end
