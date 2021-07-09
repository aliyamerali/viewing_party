class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  has_many :friended_users, foreign_key: :friender_id, class_name: 'Friend', dependent: :destroy # , inverse_of: :user
  has_many :friendees, through: :friended_users

  has_many :friending_users, foreign_key: :friendee_id, class_name: 'Friend', dependent: :destroy # , inverse_of: :user
  has_many :frienders, through: :friending_users, dependent: :destroy

  has_many :invitations, dependent: :destroy
  has_many :parties, dependent: :destroy
  # has_many :attending_parties, through:invitations

  has_secure_password
end
