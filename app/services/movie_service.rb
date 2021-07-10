class MovieService
  def self.top_40
    response_1 = Faraday.get "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=1"
    page_1 = JSON.parse(response_1.body, symbolize_names: true)
    top_40 = page_1[:results]

    response_2 = Faraday.get "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=2"
    page_2 = JSON.parse(response_1.body, symbolize_names: true)
    top_40 << page_2[:results]

    top_40.flatten
  end
end
