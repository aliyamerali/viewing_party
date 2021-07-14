class Party < ApplicationRecord
  belongs_to :user, foreign_key: :host_id, class_name: 'User'
  has_many :invitations, dependent: :destroy

  def invited_friends
    invitations.map do |invite|
      User.find(invite.guest_id)
    end
  end
end
