class Invitation < ApplicationRecord
  belongs_to :party
  belongs_to :user, foreign_key: :guest_id, class_name: 'User'
end
