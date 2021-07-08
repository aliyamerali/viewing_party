class User < ApplicationRecord
  has_many :friended_users, foreign_key: :friender_id, class_name: 'Friend'
  has_many :friendees, through: :friended_users

  has_many :friending_users, foreign_key: :friendee_id, class_name: 'Friend'
  has_many :frienders, through: :friending_users
end
