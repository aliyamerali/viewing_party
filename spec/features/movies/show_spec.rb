require 'rails_helper'

RSpec.describe 'Movie Show page' do
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

    fill_in 'user[email]', with: 'amaf@test.com'
    fill_in 'user[password]', with: '1234'
    fill_in 'user[password_confirmation]', with: '1234'
    click_on 'Create User'

    visit "/movies/#{@movie_id}"
  end

  it 'shows the movie details' do
    expect(page).to have_content("Harry Potter and the Philosopher's Stone")
    expect(page).to have_content("Vote Average: 7.9")
    expect(page).to have_content("Runtime: 2 hours 32 minutes")
    expect(page).to have_content("Adventure")
    expect(page).to have_content("Fantasy")
    expect(page).to have_content("Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard -- with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths -- and about the villain who's to blame.")
  end

  it 'shows first ten movie cast' do
    expect(page).to have_content("Daniel Radcliffe")
    expect(page).to have_content("Harry Potter")
    expect(page).to have_content("Rupert Grint")
    expect(page).to have_content("Ron Weasley")
    expect(page).to have_content("Emma Watson")
    expect(page).to have_content("Hermione Granger")
    expect(page).to have_content("Richard Harris")
    expect(page).to have_content("Albus Dumbledore")
    expect(page).to have_content("Tom Felton")
    expect(page).to have_content("Draco Malfoy")
    expect(page).to have_content("Alan Rickman")
    expect(page).to have_content("Severus Snape")
    expect(page).to have_content("Robbie Coltrane")
    expect(page).to have_content("Rubeus Hagrid")
    expect(page).to have_content("Maggie Smith")
    expect(page).to have_content("Minerva McGonagall")
    expect(page).to have_content("Richard Griffiths")
    expect(page).to have_content("Vernon Dursley")
    expect(page).to have_content("Ian Hart")
    expect(page).to have_content("Professor Quirrell/Voldemort")
  end

  it 'shows all reviews' do
    expect(page).to have_content("Total Reviews: 3")
    expect(page).to have_content("John Chard")
    expect(page).to have_content("A street credibility Pygmallion!")
    expect(page).to have_content("Ryan")
    expect(page).to have_content("You and I are such similar creatures, Vivian.")
  end

  it 'has a button to create a new party' do
    expect(page).to have_button("Create a Viewing Party")
    click_button("Create a Viewing Party")
    expect(page).to have_current_path("/parties/new?movie_id=671")
  end
end
