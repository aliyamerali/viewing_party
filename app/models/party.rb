class Party < ApplicationRecord
  belongs_to :user, foreign_key: :host_id, class_name: 'User'
  has_many :invitations, dependent: :destroy
end
