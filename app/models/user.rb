class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  has_many :friended_users, foreign_key: :friender_id, class_name: 'Friend', dependent: :destroy # , inverse_of: :user
  has_many :friendees, through: :friended_users

  has_many :friending_users, foreign_key: :friendee_id, class_name: 'Friend', dependent: :destroy # , inverse_of: :user
  has_many :frienders, through: :friending_users, dependent: :destroy

  # has_many :invitations, dependent: :destroy
  has_many :invitations, foreign_key: :guest_id, class_name: 'Invitation', dependent: :destroy
  # has_many :parties, dependent: :destroy
  has_many :parties, foreign_key: :host_id, class_name: 'Party', dependent: :destroy

  # For checkin - do we need this additional relationship? Or can we just go through existing tables?
  # has_many :attending_parties, through: :invitations

  has_secure_password
  
  def attending_parties
    Party.joins(:invitations).select('parties.*').where('invitations.guest_id = ?', self.id)
  end
end
