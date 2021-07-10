require 'rails_helper'

RSpec.describe 'search movies' do
  before :each do
    @query = "The Story"
    response_body_1 = File.read('spec/fixtures/movie_search_1.json')
    response_body_2 = File.read('spec/fixtures/movie_search_2.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{@query}&page=1").
        to_return(status: 200, body: response_body_1, headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{@query}&page=2").
        to_return(status: 200, body: response_body_2, headers: {})

    visit '/register'

    fill_in 'user[email]', with: 'amaf@test.com'
    fill_in 'user[password]', with: '1234'
    fill_in 'user[password_confirmation]', with: '1234'
    click_on 'Create User'

    visit discover_path
  end

  it 'has a form for movie search' do
    expect(page).to have_field(:search)
    fill_in :search, with: @query
    click_button('Find Movies')
    expect(current_path).to eq(movies_path)
  end

  it 'submitting movie search form directs to results on /movies page' do
    fill_in :search, with: @query
    click_button('Find Movies')

    expect(current_path).to eq(movies_path)
    expect(page).to have_content("Perfume: The Story of a Murderer")
    expect(page).to have_content("Vote Average: 7.3")
    expect(page).to have_content("The Story of Mother's Day")
    expect(page).to have_content("Vote Average: 5")
  end
end
