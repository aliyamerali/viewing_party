class Party < ApplicationRecord
  validates :date, presence: true
  validates :event_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true
  validates :host_id, presence: true
  validates :duration, presence: true
  # validates :duration, numericality: {greater_than_or_equal_to: Movie.runtime[:total_in_minutes]}

  belongs_to :user, foreign_key: :host_id, class_name: 'User'
  has_many :invitations, dependent: :destroy

  def host
    User.find(host_id)
  end

  def invited_friends
    invitations.map do |invite|
      User.find(invite.guest_id)
    end
  end
end
