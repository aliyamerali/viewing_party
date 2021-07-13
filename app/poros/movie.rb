class Movie
  attr_reader :id, :title, :vote_average, :runtime, :genres, :overview

  def initialize(movie_info)
    @id = movie_info[:id]
    @title = movie_info[:title]
    @vote_average = movie_info[:vote_average]
    @runtime = minutes_to_hr_min(movie_info[:runtime]) if movie_info[:runtime]
    @genres = format_genres(movie_info[:genres]) if movie_info[:genres]
    @overview = movie_info[:overview]
  end

  def format_genres(genres_array)
    test = genres_array.map do |genre|
      genre[:name]
    end
  end

  def minutes_to_hr_min(minutes)
    runtime = {}
    runtime[:hours] = (minutes/60).round
    runtime[:minutes] = minutes % 60
    runtime
  end

end
