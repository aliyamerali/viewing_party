class Party < ApplicationRecord
  belongs_to :user, foreign_key: :host_id, class_name: 'User'
  has_many :invitations, dependent: :destroy

  def host?(user_id)
    host_id == user_id
  end

  def invited_friends
    invitations = Invitation.where('party_id = ?', id)
    invitations.map do |invite|
      User.find(invite.guest_id)
    end
  end
end
