require 'rails_helper'

RSpec.describe Party do
  describe "validations" do
    it {should validate_presence_of(:date)}
    it {should validate_presence_of(:event_time)}
    it {should validate_presence_of(:movie_id)}
    it {should validate_presence_of(:host_id)}
    it {should validate_presence_of(:movie_title)}
    it {should validate_presence_of(:duration)}
  end

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
    it '#host returns the user that is hosting' do
      expect(@party.host).to eq(@user1)
    end

    it '#invited_friends returns an array of user objects for friends invited' do
      expect(@party.invited_friends).to eq([@user2, @user3])
    end
  end
end
