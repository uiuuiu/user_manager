class Role < ApplicationRecord
  has_many :team_roles, dependent: :destroy
  belongs_to :team, optional: true
end
