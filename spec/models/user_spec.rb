require 'rails_helper'

RSpec.describe User do
  describe "validations" do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end
  describe 'relationships' do
    it {should have_many(:friended_users).class_name('Friend')}
    it {should have_many(:friendees).through(:friended_users)}
    it {should have_many(:friending_users).class_name('Friend')}
    it {should have_many(:frienders).through(:friending_users)}

    it {should have_many(:invitations)}
    it {should have_many(:parties)}
  end
  describe 'friend search' do
    it 'can find friends' do
      user1 = User.create!(email: '1test@test.com', password: '1234', password_confirmation: '1234')
      user2 = User.create!(email: '2test@test.com', password: '1234', password_confirmation: '1234')
      user3 = User.create!(email: '3test@test.com', password: '1234', password_confirmation: '1234')
      user4 = User.create!(email: '4test@test.com', password: '1234', password_confirmation: '1234')
      Friend.create!(friender_id: user1.id, friendee_id: user2.id)
      Friend.create!(friender_id: user1.id, friendee_id: user3.id)
      Friend.create!(friender_id: user2.id, friendee_id: user3.id)

      expect(user1.friends_list).to match_array([user2, user3])
      expect(user1.friends_list).to_not match_array([user4])
      expect(user2.friends_list).to match_array([user3])
      expect(user1.friends_list).to_not match_array([user1, user2, user4])
      expect(user3.friends_list).to match_array([])
    end
  end
end
