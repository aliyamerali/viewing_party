require 'rails_helper'

RSpec.describe 'Movies API Service' do
  describe 'class methods' do
    it '.top40 returns top 40 movies as an array of hashes' do
      response_body_1 = File.read('spec/fixtures/top_rated_1.json')
      response_body_2 = File.read('spec/fixtures/top_rated_2.json')
      stub_request(:get,"https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=1").
          to_return(status: 200, body: response_body_1, headers: {})

      stub_request(:get,"https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=2").
          to_return(status: 200, body: response_body_2, headers: {})

      top40 = MovieService.top40

      expect(top40.length).to eq(40)
      expect(top40.first).to have_key(:title)
      expect(top40.first).to have_key(:vote_average)
    end

    it '.search returns an array of hashes with search results from query' do
      query = "The Story"
      response_body_1 = File.read('spec/fixtures/movie_search_1.json')
      response_body_2 = File.read('spec/fixtures/movie_search_2.json')
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{query}&page=1").
          to_return(status: 200, body: response_body_1, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{query}&page=2").
          to_return(status: 200, body: response_body_2, headers: {})

      search_result = MovieService.search(query)

      expect(search_result.length).to eq(40)
      expect(search_result.first[:title]).to eq("Perfume: The Story of a Murderer")
      expect(search_result.last[:title]).to eq("The Story of Mother's Day")
    end

    it '.details returns movie details for a given movie' do
      movie_id =671
      response_body_1 = File.read('spec/fixtures/movie_details.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['MOVIE_API_KEY']}").
          to_return(status: 200, body: response_body_1, headers: {})

      details = MovieService.details(movie_id)
      expect(details[:id]).to eq(movie_id)
      expect(details).to have_key(:title)
      expect(details).to have_key(:vote_average)
      expect(details).to have_key(:runtime)
      expect(details).to have_key(:genres)
      expect(details).to have_key(:overview)
      expect(details[:genres].first[:name]).to eq("Adventure")
    end

    it '.credits returns movie cast'

    it '.reviews returns movie reviews'
  end
end
