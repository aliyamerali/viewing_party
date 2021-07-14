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

    it '.details returns a single movie object with all attributes populated' do
      movie_id = 671
      response_body = File.read('spec/fixtures/movie_details.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['MOVIE_API_KEY']}").
          to_return(status: 200, body: response_body, headers: {})

      movie = MovieFacade.details(movie_id)
      expect(movie.id).to eq(movie_id)
      expect(movie.title).to eq("Harry Potter and the Philosopher's Stone")
      expect(movie.vote_average).to eq(7.9)
      expect(movie.runtime).to eq({:hours=>2, :minutes=>32, :total_in_minutes=>152})
      expect(movie.genres).to eq(["Adventure", "Fantasy"])
      expect(movie.overview).to eq("Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard -- with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths -- and about the villain who's to blame.")
    end

    describe '.first_ten_cast' do
      it 'returns 10 cast_member objects if 10 are available' do
        movie_id = 671
        response_body = File.read('spec/fixtures/movie_credits.json')
        stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{ENV['MOVIE_API_KEY']}").
            to_return(status: 200, body: response_body, headers: {})

        cast = MovieFacade.first_ten_cast(movie_id)

        expect(cast.length).to eq(10)
        expect(cast.first.actor).to eq("Daniel Radcliffe")
        expect(cast.first.character).to eq("Harry Potter")
      end

      it 'returns all cast_member objects if there are less than 10' do
        movie_id = 671
        response_body = File.read('spec/fixtures/movie_credits_short.json')
        stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{ENV['MOVIE_API_KEY']}").
            to_return(status: 200, body: response_body, headers: {})

        cast = MovieFacade.first_ten_cast(movie_id)

        expect(cast.length).to eq(2)
        expect(cast.first.actor).to eq("Daniel Radcliffe")
        expect(cast.first.character).to eq("Harry Potter")
      end
    end

    it '.reviews returns movie reviews' do
      movie_id = 114
      response_body = File.read('spec/fixtures/movie_reviews.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/reviews?api_key=#{ENV['MOVIE_API_KEY']}").
          to_return(status: 200, body: response_body, headers: {})

      reviews = MovieFacade.reviews(movie_id)
      excerpt = "A street credibility Pygmallion!"

      expect(reviews.length).to eq(3)
      expect(reviews.first.author).to eq("John Chard")
      expect(reviews.last.author).to eq("Ryan")
      expect(reviews.first.content.include?(excerpt)).to eq(true)
    end

  end
end
