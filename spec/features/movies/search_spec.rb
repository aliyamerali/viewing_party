require 'rails_helper'

RSpec.describe 'search movies' do
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
