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

    visit '/movies/671'
    click_button "Create a Viewing Party"
  end

  it 'clicking "Create a Viewing Party" takes you to a new party page for the movie' do
    expect(page).to have_current_path(parties_new_path)
    expect(page).to have_content("Viewing Party For: Harry Potter and the Philosopher's Stone")
  end
end
