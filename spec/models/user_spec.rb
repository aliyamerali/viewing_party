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

  describe 'instance methods' do
    it '#friend search can find friends' do
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
         
    it '#attending_parties returns parties the user is invited to' do
      movie = Movie.new({id: 123,
                   title: "Movie",
                   vote_average: 2.3,
                   runtime: 123,
                   genres: [{name: "Horror"}],
                   overview: "A movie"
                   })
      @user1 = User.create!(email: 'test1@test.com', password: '1234', password_confirmation: '1234')
      @user2 = User.create!(email: 'test2@test.com', password: '2234', password_confirmation: '2234')
      @user3 = User.create!(email: 'test3@test.com', password: '3234', password_confirmation: '3234')

      @party = Party.create!(host_id: @user1.id,
                            movie_id: movie.id,
                            movie_title: movie.title,
                            event_time: '2pm',
                            duration: 150,
                            date: '1/2/21')

      Invitation.create!(party_id: @party.id, guest_id: @user2.id)
      Invitation.create!(party_id: @party.id, guest_id: @user3.id)    
      expect(@user1.attending_parties.first).to eq(nil)
      expect(@user2.attending_parties.first).to eq(@party)
      expect(@user3.attending_parties.first).to eq(@party)
    end
  end
end
