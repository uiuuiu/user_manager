class User < ApplicationRecord
  include UserAssociationPreloadWithParams
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one_attached :avatar

  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users
  has_many :belongs_current_user_teams, -> { where(id: User.current_user_team_ids || []) }, through: :team_users, source: :team

  has_many :users_from_teams, -> { distinct }, through: :teams, source: :users
  has_many :owned_teams, class_name: "Team", foreign_key: "owner_id"

  has_many :current_team_user_roles, -> { where("team_users.team_id = ?", User.current_team_id) }, through: :team_users, source: :team_user_roles
  has_many :current_team_roles, through: :current_team_user_roles, source: :role

  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 50}
  validates :username, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 20}
  validates :first_name, presence: true, length: {minimum: 3, maximum: 20}
  validates :last_name, presence: true, length: {minimum: 3, maximum: 20}
  validates :password, presence: true, length: {minimum: 6, maximum: 20}
  validates :password_confirmation, presence: true
  validates :password, confirmation: true
end
