require 'rails_helper'

RSpec.describe 'Movies API Service' do
  describe 'class methods' do
    it '#top40 returns top 40 movies as an array of hashes' do
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
  end
end
