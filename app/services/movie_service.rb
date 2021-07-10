class MovieService
  def self.top40
    response1 = Faraday.get "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=1"
    page1 = JSON.parse(response1.body, symbolize_names: true)
    top40 = page1[:results]

    response2 = Faraday.get "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=2"
    page2 = JSON.parse(response2.body, symbolize_names: true)
    top40 << page2[:results]

    top40.flatten
  end

  def self.search(query)
    response1 = Faraday.get "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{query}&page=1"
    page1 = JSON.parse(response1.body, symbolize_names: true)
    search_result = page1[:results]

    response2 = Faraday.get "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{query}&page=2"
    page2 = JSON.parse(response2.body, symbolize_names: true)
    search_result << page2[:results]

    search_result.flatten
  end
end
