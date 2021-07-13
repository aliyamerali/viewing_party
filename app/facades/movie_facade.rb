class MovieFacade

  def self.top40
    movies = []

    2.times.with_index do |index|
      movie_data = MovieService.top40(index+1)[:results]
      movie_data.each do |movie|
        movies << Movie.new(movie)
      end
    end

    movies
  end

  def self.search(query)
    movies = []

    2.times.with_index do |index|
      movie_data = MovieService.search(query, index+1)[:results]
      movie_data.each do |movie|
        movies << Movie.new(movie)
      end
    end

    movies
  end

end
