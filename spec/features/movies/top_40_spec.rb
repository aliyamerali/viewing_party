require 'rails_helper'

RSpec.describe 'top 40 functionality' do
  before :each do
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
  end

  it 'discover page has a button to see top 40' do
    expect(page).to have_button('Find Top Rated Movies')
    click_button('Find Top Rated Movies')
    expect(current_path).to eq(movies_path)
  end

  describe 'shows top 40 movie results on /movie page if no search params present' do

    it 'if no search term defined, returns top 40 rated movies' do
      visit movies_path
      expect(page).to have_content("The Shawshank Redemption")
      expect(page).to have_content("Vote Average: 8.7")
      expect(page).to have_content("Zack Snyder's Justice League")
      expect(page).to have_content("Vote Average: 8.4")
    end

    it 'has a button to show top 40 and a search bar to search movies' do
      visit movies_path
      expect(page).to have_field(:search)
      expect(page).to have_button('Find Movies')
      expect(page).to have_button('Find Top Rated Movies')
    end
  end

  it 'each title on movies page links to the movies detail page' do
    visit movies_path
    expect(page).to have_link("The Shawshank Redemption", :href=>'/movies/278')
    expect(page).to have_link("Zack Snyder's Justice League", :href=>'/movies/791373')
  end

  it 'unauthenticated users do not see search capability' do
    visit root_path
    click_button("Log Out")

    visit discover_path
    expect(page).to have_current_path(root_path)
  end
end
