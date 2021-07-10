require 'rails_helper'

RSpec.describe 'movies discover page' do
  it 'has a button to discover top 40' do
    response_body_1 = File.read('spec/fixtures/top_rated_1.json')
    response_body_2 = File.read('spec/fixtures/top_rated_2.json')
    stub_request(:get,"https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=1").
        to_return(status: 200, body: response_body_1, headers: {})

    stub_request(:get,"https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=2").
        to_return(status: 200, body: response_body_2, headers: {})

        
    visit '/register'

    fill_in 'user[email]', with: 'amaf@test.com'
    fill_in 'user[password]', with: '1234'
    fill_in 'user[password_confirmation]', with: '1234'
    click_on 'Create User'

    visit discover_path

    expect(page).to have_button('Find Top Rated Movies')
    click_button('Find Top Rated Movies')
    expect(current_path).to eq(movies_path)
  end
end
