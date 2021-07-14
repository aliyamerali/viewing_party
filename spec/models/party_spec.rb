require 'rails_helper'

RSpec.describe Party do
  describe 'relationships' do
    it {should belong_to(:user)}
    it {should have_many(:invitations)}
  end

  before :each do
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
  end

  describe 'instance methods' do
    it '#host? returns true if the user entered is host, else false' do
      expect(@party.host?(@user1.id)).to eq(true)
      expect(@party.host?(@user2.id)).to eq(false)
      expect(@party.host?(@user3.id)).to eq(false)
    end

    it '#invited_friends returns an array of user objects for friends invited' do
      expect(@party.invited_friends).to eq([@user2, @user3])
    end
  end
end
