class MovieFacade
  def self.top40
    movies = []

    2.times do |index|
      movie_data = MovieService.top40(index + 1)[:results]
      movie_data.each do |movie|
        movies << Movie.new(movie)
      end
    end

    movies
  end

  def self.search(query)
    movies = []

    2.times do |index|
      movie_data = MovieService.search(query, index + 1)[:results]
      movie_data.each do |movie|
        movies << Movie.new(movie)
      end
    end

    movies
  end

  def self.details(id)
    Movie.new(MovieService.details(id))
  end

  def self.first_ten_cast(id)
    credits = MovieService.credits(id)
    cast = credits[:cast].map do |cast_member_info|
      CastMember.new(cast_member_info)
    end

    if cast.count > 10
      cast.take(10)
    else
      cast
    end
  end

  def self.reviews(id)
    review_summary = MovieService.reviews(id)
    review_summary[:results].map do |review|
      Review.new(review)
    end
  end
end
