require 'rails_helper'

RSpec.describe 'Creation of a new viewing party' do
  before :each do
    @movie_id = 671
    response_body1 = File.read('spec/fixtures/movie_details.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_id}?api_key=#{ENV['MOVIE_API_KEY']}").
    to_return(status: 200, body: response_body1, headers: {})

    response_body2 = File.read('spec/fixtures/movie_credits.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_id}/credits?api_key=#{ENV['MOVIE_API_KEY']}").
    to_return(status: 200, body: response_body2, headers: {})

    response_body3 = File.read('spec/fixtures/movie_reviews.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_id}/reviews?api_key=#{ENV['MOVIE_API_KEY']}").
    to_return(status: 200, body: response_body3, headers: {})

    visit '/register'

    email = 'amaf@test.com'
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: '1234'
    fill_in 'user[password_confirmation]', with: '1234'
    click_on 'Create User'

    @user = User.find_by(email: email)
    @friend1 = User.create!(email: 'test1@test.com', password: '1234', password_confirmation: '1234')
    @friend2 = User.create!(email: 'test2@test.com', password: '2234', password_confirmation: '2234')

    Friend.create!(friender_id: @user.id, friendee_id: @friend1.id)
    Friend.create!(friender_id: @user.id, friendee_id: @friend2.id)

    visit '/movies/671'
    click_button "Create a Viewing Party"
  end

  describe 'Authenticated user flow' do
    it 'clicking "Create a Viewing Party" takes you to a new party page for the movie' do
      expect(page).to have_current_path("/parties/new?movie_id=671")
      expect(page).to have_content("Viewing Party For: Harry Potter and the Philosopher's Stone")
    end

    describe 'has fields to create a new party' do
      it 'has a duration field with a default and minimum value of movie runtime' do
        expect(page).to have_field('party[duration]', :with => 152)
      end

      it 'has additional required fields' do
        expect(page).to have_field 'party[date]'
        expect(page).to have_field 'party[event_time]'
      end

      it 'has checkboxes for all a user\'s friends' do
        expect(page).to have_css("##{@friend1.id}")
        expect(page).to have_css("##{@friend2.id}")
      end

      xit 'doesn\'t allow submission with duration less than movie runtime' do
        fill_in 'party[duration]', with: 151
        click_button("Create Party")
        expect(page).to have_current_path("/parties/new?movie_id=671")
      end
    end

    describe 'submitting the form creates a new party' do
      it 'redirects to the dashboard on submission and shows new party' do
        fill_in 'party[duration]', with: 170
        fill_in 'party[date]', with: '7/25/2021'
        fill_in 'party[event_time]', with: '3:30 PM'
        click_button("Create Party")

        expect(page).to have_current_path("/dashboard")
        within("#671") do
          expect(page).to have_link("Harry Potter and the Philosopher's Stone", :href => '/movies/671')
          expect(page).to have_content('7/25/2021')
          expect(page).to have_content('3:30 PM')
          expect(page).to have_content('Hosting')
          # expect(page).to have_content() INVITED FRIENDS
        end
      end

    end
    #checkboxes to add friends
  end
end
