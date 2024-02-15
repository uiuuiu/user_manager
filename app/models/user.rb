class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one_attached :avatar

  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users

  has_many :users_from_teams, -> { distinct }, through: :teams, source: :users

  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 50}
  validates :username, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 20}
  validates :first_name, presence: true, length: {minimum: 3, maximum: 20}
  validates :last_name, presence: true, length: {minimum: 3, maximum: 20}
  validates :password, presence: true, length: {minimum: 6, maximum: 20}
  validates :password_confirmation, presence: true
  validates :password, confirmation: true
end
