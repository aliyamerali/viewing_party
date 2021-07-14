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

  it 'has a button to show top 40 and a search bar to search movies' do
    fill_in :search, with: @query
    click_button('Find Movies')

    expect(page).to have_field(:search)
    expect(page).to have_button('Find Movies')
    expect(page).to have_button('Find Top Rated Movies')
  end

  it 'each title on movies page links to the movies detail page' do
    fill_in :search, with: @query
    click_button('Find Movies')

    expect(page).to have_link("Perfume: The Story of a Murderer", :href=>'/movies/1427')
    expect(page).to have_link("The Story of Mother's Day", :href=>'/movies/828714')
  end

  it 'unauthenticated users do not see search capability' do
    visit root_path
    click_button("Log Out")

    visit discover_path
    expect(page).to have_current_path(root_path)
  end
end
