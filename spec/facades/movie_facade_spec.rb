require 'rails_helper'

RSpec.describe 'Movie Facade' do
  describe 'class methods' do
    it '.top40 returns array of movie objects of top 40 movies' do
      response_body_1 = File.read('spec/fixtures/top_rated_1.json')
      response_body_2 = File.read('spec/fixtures/top_rated_2.json')
      stub_request(:get,"https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=1").
          to_return(status: 200, body: response_body_1, headers: {})

      stub_request(:get,"https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=2").
          to_return(status: 200, body: response_body_2, headers: {})

      top40 = MovieFacade.top40
      expect(top40.length).to eq(40)
      expect(top40.first.id).to eq(19404)
      expect(top40.first.title).to eq("Dilwale Dulhania Le Jayenge")
      expect(top40.last.id).to eq(378064)
      expect(top40.last.title).to eq("A Silent Voice: The Movie")
    end

    it '.search returns array of 40 movie objects based on search term' do
      query = "The Story"
      response_body_1 = File.read('spec/fixtures/movie_search_1.json')
      response_body_2 = File.read('spec/fixtures/movie_search_2.json')
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{query}&page=1").
          to_return(status: 200, body: response_body_1, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{query}&page=2").
          to_return(status: 200, body: response_body_2, headers: {})

      search_result = MovieFacade.search(query)

      expect(search_result.length).to eq(40)
      expect(search_result.first.title).to eq("Perfume: The Story of a Murderer")
      expect(search_result.last.title).to eq("The Story of Mother's Day")
    end
  end
end
