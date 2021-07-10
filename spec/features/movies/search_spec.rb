require 'rails_helper'

RSpec.describe 'search movies' do
  it 'if no search term defined, returns top 40 rated movies' do
    response_body_1 = File.read('spec/fixtures/top_rated_1.json')
    response_body_2 = File.read('spec/fixtures/top_rated_2.json')
    stub_request(:get,'https://api.themoviedb.org/3/movie/top_rated?page=1').
        to_return(status: 200, body: response_body_1, headers: {})

    stub_request(:get,'https://api.themoviedb.org/3/movie/top_rated?page=2').
        to_return(status: 200, body: response_body_2, headers: {})

    user = User.create(email: 'amaf@test.com', password: '1234', password_confirmation: '1234')
    visit root_path
    fill_in :email, with: 'amaf@test.com'
    fill_in :password, with: '1234'
    click_button "Sign In"

    visit movies_path
    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to have_content("Vote Average: 8.7")
    expect(page).to have_content("Zack Snyder's Justice League")
    expect(page).to have_content("Vote Average: 8.4")
  end

  xit 'can search for movies' do
    response_body = File.read('spec/fixtures/movie_search.json')
    stub_request(:get,'https://api.themoviedb.org/3/search/movie').
        to_return(status: 200, body: response_body, headers: {})

    visit '/discover'

    #???expect(page).to have_field(:search)
    fill_in :search, with: 'Phoenix'
    click_button 'Search'

    expect(page).to have_content('Dark Phoenix')
  end
  # visits movies page
  # searchbox to search for movies
  # fill it in with movie
  # taken to search result with the movies that matches
end
