require 'rails_helper'

RSpec.describe 'Movies API Service' do
  describe 'class methods' do
    it '.top40 returns data from top movies endpoint' do
      response_body_1 = File.read('spec/fixtures/top_rated_1.json')
      stub_request(:get,"https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=1").
          to_return(status: 200, body: response_body_1, headers: {})

      top40 = MovieService.top40(1)

      expect(top40[:results].length).to eq(20)
      expect(top40[:results].first).to have_key(:title)
      expect(top40[:results].first).to have_key(:vote_average)
    end

    it '.search returns data from search endpoint' do
      query = "The Story"
      response_body_1 = File.read('spec/fixtures/movie_search_1.json')
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{query}&page=1").
          to_return(status: 200, body: response_body_1, headers: {})

      search_result = MovieService.search(query, 1)

      expect(search_result[:results].length).to eq(20)
      expect(search_result[:results].first[:title]).to eq("Perfume: The Story of a Murderer")
      expect(search_result[:results].last[:title]).to eq("The Story of Film: An Odyssey")
    end

    it '.details returns movie details for a given movie' do
      movie_id = 671
      response_body = File.read('spec/fixtures/movie_details.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['MOVIE_API_KEY']}").
          to_return(status: 200, body: response_body, headers: {})

      details = MovieService.details(movie_id)
      expect(details[:id]).to eq(movie_id)
      expect(details).to have_key(:title)
      expect(details).to have_key(:vote_average)
      expect(details).to have_key(:runtime)
      expect(details).to have_key(:genres)
      expect(details).to have_key(:overview)
      expect(details[:genres].first[:name]).to eq("Adventure")
    end

    it '.credits returns movie credit data' do
      movie_id = 671
      response_body = File.read('spec/fixtures/movie_credits.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{ENV['MOVIE_API_KEY']}").
          to_return(status: 200, body: response_body, headers: {})

      credits = MovieService.credits(movie_id)

      expect(credits[:id]).to eq(movie_id)
      expect(credits).to have_key(:cast)
      expect(credits[:cast].first).to have_key(:character)
      expect(credits[:cast].first[:name]).to eq("Daniel Radcliffe")
      expect(credits[:cast].first[:character]).to eq("Harry Potter")
    end

    it '.reviews returns movie reviews' do
      movie_id = 114
      response_body = File.read('spec/fixtures/movie_reviews.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/reviews?api_key=#{ENV['MOVIE_API_KEY']}").
          to_return(status: 200, body: response_body, headers: {})

      reviews = MovieService.reviews(movie_id)

      expect(reviews[:results].length).to eq(3)
      expect(reviews[:results].first).to have_key(:author)
      expect(reviews[:results].first).to have_key(:content)
    end

    it '.similar returns similar movies for a given movie' do
      movie_id = 671
      response_body = File.read('spec/fixtures/similar_movies.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/similar?api_key=#{ENV['MOVIE_API_KEY']}").
          to_return(status: 200, body: response_body, headers: {})

      similar_movies = MovieService.similar(movie_id)
      expect(similar_movies.class).to eq(Hash)
      expect(similar_movies[:results].class).to eq(Array)
      expect(similar_movies[:results].first).to have_key(:id)
      expect(similar_movies[:results].first).to have_key(:overview)
      expect(similar_movies[:results].first).to have_key(:vote_average)
    end
  end
end
